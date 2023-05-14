package com.Softwaring.OdeProServer.service;

import com.Softwaring.OdeProServer.dto.ActiveProvisionDTO;
import com.Softwaring.OdeProServer.dto.PassengerDTO;
import com.Softwaring.OdeProServer.dto.UsedProvisionDTO;
import com.Softwaring.OdeProServer.entity.ActiveProvision;
import com.Softwaring.OdeProServer.entity.Passenger;
import com.Softwaring.OdeProServer.entity.UsedProvision;
import com.Softwaring.OdeProServer.exception.NotFoundException;
import com.Softwaring.OdeProServer.repository.ActiveProvisionRepository;
import com.Softwaring.OdeProServer.repository.PassengerRepository;
import com.Softwaring.OdeProServer.repository.TransactionsRepository;
import com.Softwaring.OdeProServer.repository.UsedProvisionRepository;
import lombok.AllArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class PassengerService {
    private final ModelMapper modelMapper = new ModelMapper();
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
                .orElseThrow(() -> new NotFoundException(Passenger.class, PID));

        ActiveProvision activeProvision = activeProvisionRepository
                .findByPassenger(passenger)
                .orElseThrow(() -> new NotFoundException(ActiveProvision.class, PID));

        return modelMapper.map(activeProvision, ActiveProvisionDTO.class);
    }

    public List<UsedProvisionDTO> getUsedProvisionsByPassengerID(String PID) {
        Passenger passenger = passengerRepository
                .findByPID(PID)
                .orElseThrow(() -> new NotFoundException(Passenger.class, PID));

        List<UsedProvision> usedProvisionList = usedProvisionRepository
                .findByPassenger(passenger)
                .orElseThrow(() -> new NotFoundException(UsedProvision.class, PID));
        if (usedProvisionList.isEmpty()) throw new NotFoundException(UsedProvision.class, PID);
        return mapList(usedProvisionList, UsedProvisionDTO.class);
    }

    public PassengerDTO getPassenger(String PID) {
        Passenger passenger = passengerRepository
                .findByPID(PID)
                .orElseThrow(() -> new NotFoundException(Passenger.class, PID));
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

    <S, T> List<T> mapList(List<S> source, Class<T> targetClass) {
        return source
                .stream()
                .map(element -> modelMapper.map(element, targetClass))
                .collect(Collectors.toList());
    }
}
