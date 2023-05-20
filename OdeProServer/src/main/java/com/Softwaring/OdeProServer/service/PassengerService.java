package com.Softwaring.OdeProServer.service;

import com.Softwaring.OdeProServer.dto.*;
import com.Softwaring.OdeProServer.entity.ActiveProvision;
import com.Softwaring.OdeProServer.entity.Passenger;
import com.Softwaring.OdeProServer.entity.Transactions;
import com.Softwaring.OdeProServer.entity.UsedProvision;
import com.Softwaring.OdeProServer.exception.NotFoundException;
import com.Softwaring.OdeProServer.repository.ActiveProvisionRepository;
import com.Softwaring.OdeProServer.repository.PassengerRepository;
import com.Softwaring.OdeProServer.repository.TransactionsRepository;
import com.Softwaring.OdeProServer.repository.UsedProvisionRepository;
import lombok.AllArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class PassengerService {
    private final ModelMapper modelMapper = new ModelMapper();
    private final BankService bankService;
    private PassengerRepository passengerRepository;
    private ActiveProvisionRepository activeProvisionRepository;
    private UsedProvisionRepository usedProvisionRepository;
    private TransactionsRepository transactionsRepository;

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

    public void closeProvision(CloseProvisionRequest closeProvisionRequest) {
        List<ActiveProvisionDTO> activeProvisionDTOList = closeProvisionRequest.getActiveProvision();
        List<TransactionsDTO> transactionsDTOList = closeProvisionRequest.getTransactions();

        List<Transactions> transactions = transactionsDTOList.stream()
                .map(transactionsDTO -> {
                    Transactions transaction = modelMapper.map(transactionsDTO, Transactions.class);
                    transaction.setActiveProvision(activeProvisionRepository.findById(String.valueOf(transactionsDTO.getAID()))
                            .orElseThrow(() -> new NotFoundException(ActiveProvision.class, "AID", transactionsDTO.getAID())));
                    return transaction;
                })
                .toList();
        transactionsRepository.saveAll(transactions);

        /*List<ActiveProvision> activeProvisionList = activeProvisionDTOList.stream()
                .map(activeProvisionDTO ->
                    modelMapper.map(activeProvisionDTO, ActiveProvision.class)
                ).toList();
        activeProvisionRepository.saveAll(activeProvisionList);*/
    }
}
