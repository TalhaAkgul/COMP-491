package com.Softwaring.OdeProServer.service;

import com.Softwaring.OdeProServer.dto.*;
import com.Softwaring.OdeProServer.entity.ActiveProvision;
import com.Softwaring.OdeProServer.entity.Passenger;
import com.Softwaring.OdeProServer.entity.Transaction;
import com.Softwaring.OdeProServer.entity.UsedProvision;
import com.Softwaring.OdeProServer.exception.NotFoundException;
import com.Softwaring.OdeProServer.repository.ActiveProvisionRepository;
import com.Softwaring.OdeProServer.repository.PassengerRepository;
import com.Softwaring.OdeProServer.repository.TransactionRepository;
import com.Softwaring.OdeProServer.repository.UsedProvisionRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.time.Instant;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class PassengerService {
    private final ModelMapper modelMapper = new ModelMapper();
    private final BankService bankService;
    private PassengerRepository passengerRepository;
    private ActiveProvisionRepository activeProvisionRepository;
    private UsedProvisionRepository usedProvisionRepository;
    private TransactionRepository transactionRepository;

    public void saveUser(Passenger p) {
        passengerRepository.save(p);
    }

    public ActiveProvisionDTO getProvisionsByPassengerID(String PID) {
        Passenger passenger = passengerRepository
                .findById(PID)
                .orElseThrow(RuntimeException::new);
        System.out.println(passenger);

        ActiveProvision activeProvision = activeProvisionRepository
                .findByPassenger(passenger)
                .orElseThrow(RuntimeException::new);

        return modelMapper.map(activeProvision, ActiveProvisionDTO.class);
    }


    public ActiveProvisionDTO getActiveProvisionByPassengerID(String PID) {
        Passenger passenger = passengerRepository
                .findByPID(PID)
                .orElseThrow(() -> new NotFoundException(Passenger.class, "PID", PID));

        ActiveProvision activeProvision = activeProvisionRepository
                .findByPassenger(passenger)
                .orElseThrow(() -> new NotFoundException(ActiveProvision.class, "PID", PID));
        ActiveProvisionDTO result = modelMapper.map(activeProvision, ActiveProvisionDTO.class);
        result.setHiddenCardNo(bankService.getHiddenCardNo(activeProvision.getUniqueCardId()));
        return result;
    }

    public List<UsedProvisionDTO> getUsedProvisionsByPassengerID(String PID) {
        Passenger passenger = passengerRepository
                .findByPID(PID)
                .orElseThrow(() -> new NotFoundException(Passenger.class, "PID", PID));

        List<UsedProvision> usedProvisionList = usedProvisionRepository
                .findByPassenger(passenger)
                .orElseThrow(() -> new NotFoundException(UsedProvision.class, "PID", PID));
        if (usedProvisionList.isEmpty()) throw new NotFoundException(UsedProvision.class, "PID", PID);

        return usedProvisionList.stream()
                .map(usedProvision -> {
                    UsedProvisionDTO usedProvisionDTO = modelMapper.map(usedProvision, UsedProvisionDTO.class);
                    usedProvisionDTO.setHiddenCardNo(bankService.getHiddenCardNo(usedProvision.getUniqueCardId()));
                    return usedProvisionDTO;
                })
                .toList();
    }

    public PassengerDTO getPassenger(String PID) {
        Passenger passenger = passengerRepository
                .findByPID(PID)
                .orElseThrow(() -> new NotFoundException(Passenger.class, "PID", PID));
        return modelMapper.map(passenger, PassengerDTO.class);
    }

    public void addPassenger(PassengerDTO passengerDTO) {
        if (passengerRepository.findByPID(passengerDTO.getPID()).isPresent()) {
            throw new IllegalArgumentException("Passenger with PID " + passengerDTO.getPID() + " already exists");
        }
        System.out.println(passengerDTO);
        Passenger passenger = modelMapper.map(passengerDTO, Passenger.class);
        passengerRepository.save(passenger);
    }

    @Transactional
    public void openProvision(OpenProvisionDTO openProvision) {
        if (activeProvisionRepository.findByPassenger_PID(openProvision.getPassengerPID()).isPresent()) {
            throw new IllegalArgumentException("Active Provision for Passenger with PID " + openProvision.getPassengerPID() + " already exists");
        }

        Passenger passenger = findOrCreatePassenger(openProvision);
        BankDTO bankDTO = modelMapper.map(openProvision, BankDTO.class);

        String uniqueCardId = bankService.openProvision(bankDTO, openProvision.getAmount());

        ActiveProvision activeProvision = modelMapper.map(openProvision, ActiveProvision.class);
        activeProvision.setAmount(openProvision.getAmount());
        activeProvision.setProvisionDate(Timestamp.from(Instant.now()));
        activeProvision.setUniqueCardId(uniqueCardId);
        System.out.println("qweqweqweqwe"+activeProvision);
        activeProvision.setPassenger(passenger);
        System.out.println("asşşdşsaşd "+activeProvision);
        activeProvisionRepository.save(activeProvision);
    }


    private Passenger findOrCreatePassenger(OpenProvisionDTO openProvision) {
        return passengerRepository
                .findByPID(openProvision.getPassengerPID())
                .orElse(passengerRepository.save(modelMapper.map(openProvision, Passenger.class)));
    }

    <S, T> List<T> mapList(List<S> source, Class<T> targetClass) {//TODO You can use this one also to set hiddenCardNo
        return source
                .stream()
                .map(element -> modelMapper.map(element, targetClass))
                .collect(Collectors.toList());
    }

    @Transactional
    public void closeProvision(CloseProvisionRequest closeProvisionRequest) {
        String flightNo = closeProvisionRequest.getFlightNo();
        List<TransactionDTO> transactionDTOList = closeProvisionRequest.getTransactions();

        Map<String, Double> passengerSpending = new HashMap<>();

        List<Transaction> transactions = transactionDTOList.stream()
                .map(transactionDTO -> {
                    Transaction transaction = modelMapper.map(transactionDTO, Transaction.class);
                    String PID = transactionDTO.getPid();
                    Long provID = activeProvisionRepository.findByPassenger_PID(PID)
                            .orElseThrow(() -> new NotFoundException(ActiveProvision.class, "PID", PID)).getAID();
                    transaction.setProvID(provID);
                    if(passengerSpending.containsKey(PID)) passengerSpending.put(PID, passengerSpending.get(PID) + transactionDTO.getAmount());
                    else passengerSpending.put(PID, transactionDTO.getAmount());
                    return transaction;
                })
                .toList();
        transactionRepository.saveAll(transactions);

        for (Map.Entry<String, Double> entry : passengerSpending.entrySet()) {
            String PID = entry.getKey();
            ActiveProvision activeProvision = activeProvisionRepository
                    .findByPassenger_PID(PID)
                    .orElseThrow(() -> new NotFoundException(ActiveProvision.class, "PID", PID));
            activeProvision.setAmount(activeProvision.getAmount() - entry.getValue());
            UsedProvision usedProvision = modelMapper.map(activeProvision, UsedProvision.class);
            usedProvision.setUID(activeProvision.getAID());
            bankService.closeProvision(activeProvision.getUniqueCardId(), activeProvision.getAmount());
            usedProvisionRepository.save(usedProvision);
            activeProvisionRepository.deleteActiveProvisionByPassenger_PID(PID);
        }

    }

    @Transactional
    public void deleteActiveProvision(String pid) {
        ActiveProvision activeProvision = activeProvisionRepository.findByPassenger_PID(pid)
                .orElseThrow(()->new NotFoundException(ActiveProvision.class,"PID",pid));
        String uniqueCardId = activeProvision.getUniqueCardId();
        double amount = activeProvision.getAmount();
        bankService.closeProvision(uniqueCardId,amount);
        activeProvisionRepository.deleteActiveProvisionByPassenger_PID(pid);
        System.out.println("DELETED");
    }

    public List<ActiveProvisionDTO> getActiveProvisionByFlightNo(String flightNo) {
        List<ActiveProvision> activeProvisions = activeProvisionRepository
                .findByFlightNo(flightNo)
                .orElseThrow(() -> new NotFoundException(ActiveProvision.class, "flightNo", flightNo));
        if (activeProvisions.isEmpty()) throw new NotFoundException(ActiveProvision.class, "flightNo", flightNo);
        return activeProvisions.stream()
                .map(activeProvision -> modelMapper.map(activeProvision, ActiveProvisionDTO.class))
                .toList();
    }
}
