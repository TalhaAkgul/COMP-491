package com.Softwaring.OdeProServer.service;

import com.Softwaring.OdeProServer.dto.OpenProvisionDTO;
import com.Softwaring.OdeProServer.repository.ActiveProvisionRepository;
import com.Softwaring.OdeProServer.repository.PassengerRepository;
import com.Softwaring.OdeProServer.repository.TransactionsRepository;
import com.Softwaring.OdeProServer.repository.UsedProvisionRepository;
import lombok.AllArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class BankService {
    private final ModelMapper modelMapper = new ModelMapper();
    private PassengerRepository passengerRepository;
    private ActiveProvisionRepository activeProvisionRepository;
    private UsedProvisionRepository usedProvisionRepository;
    private TransactionsRepository transactionsRepository;

    public void openProvision(OpenProvisionDTO openProvision) {
        if (activeProvisionRepository.findByPassenger_PID(openProvision.getPassengerPID()).isPresent()) {
            throw new IllegalArgumentException("Active Provision for Passenger with PID " + openProvision.getPassengerPID() + " already exists");
        }



    }
}
