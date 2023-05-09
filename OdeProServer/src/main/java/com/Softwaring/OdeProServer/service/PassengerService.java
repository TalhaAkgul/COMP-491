package com.Softwaring.OdeProServer.service;

import com.Softwaring.OdeProServer.dto.ActiveProvisionDTO;
import com.Softwaring.OdeProServer.dto.UsedProvisionDTO;
import com.Softwaring.OdeProServer.entity.ActiveProvision;
import com.Softwaring.OdeProServer.entity.Passenger;
import com.Softwaring.OdeProServer.entity.UsedProvision;
import com.Softwaring.OdeProServer.repository.ActiveProvisionRepository;
import com.Softwaring.OdeProServer.repository.PassengerRepository;
import com.Softwaring.OdeProServer.repository.TransactionsRepository;
import com.Softwaring.OdeProServer.repository.UsedProvisionRepository;
import lombok.AllArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class PassengerService {
    private PassengerRepository passengerRepository;
    private ActiveProvisionRepository activeProvisionRepository;
    private UsedProvisionRepository usedProvisionRepository;
    private TransactionsRepository transactionsRepository;
    private final ModelMapper modelMapper = new ModelMapper();

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
                .orElseThrow(RuntimeException::new);

        ActiveProvision activeProvision = activeProvisionRepository
                .findByPassenger(passenger)
                .orElseThrow(RuntimeException::new);

        return modelMapper.map(activeProvision, ActiveProvisionDTO.class);
    }

    public List<UsedProvisionDTO> getUsedProvisionsByPassengerID(String PID) {
        Passenger passenger = passengerRepository.findByPID(PID)
                .orElseThrow(RuntimeException::new);
        System.out.println(passenger);
        List<UsedProvision> usedProvisionList = usedProvisionRepository.findByPassenger(passenger)
                .orElseThrow(RuntimeException::new);
        System.out.println(modelMapper.map(usedProvisionList, UsedProvisionDTO.class));
        return mapList(usedProvisionList, UsedProvisionDTO.class);
    }

    <S, T> List<T> mapList(List<S> source, Class<T> targetClass) {
        return source
                .stream()
                .map(element -> modelMapper.map(element, targetClass))
                .collect(Collectors.toList());
    }
}
