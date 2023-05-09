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

        ActiveProvision activeProvision = activeProvisionRepository
                .findByPassenger(passenger)
                .orElseThrow(RuntimeException::new);

        ActiveProvisionDTO response = modelMapper.map(activeProvision, ActiveProvisionDTO.class);
        return response;
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

    public UsedProvisionDTO getUsedProvisionsByPassengerID(String PID) {
        Passenger passenger = passengerRepository.findByPID(PID)
                .orElseThrow(RuntimeException::new);

        List<UsedProvision> usedProvisionList = usedProvisionRepository.findByPassenger(passenger)
                .orElseThrow(RuntimeException::new);
        return modelMapper.map(usedProvisionList, UsedProvisionDTO.class);
    }
}
