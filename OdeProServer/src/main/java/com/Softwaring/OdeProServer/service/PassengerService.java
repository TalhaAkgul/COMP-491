package com.Softwaring.OdeProServer.service;

import com.Softwaring.OdeProServer.dto.ActiveProvisionDto;
import com.Softwaring.OdeProServer.dto.PassengerDto;
import com.Softwaring.OdeProServer.dto.UsedProvisionDto;
import com.Softwaring.OdeProServer.entity.Passenger;
import com.Softwaring.OdeProServer.entity.UsedProvision;
import com.Softwaring.OdeProServer.repository.PassengerRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PassengerService {
    private PassengerRepository passengerRepository;
    private final ModelMapper modelMapper = new ModelMapper();
    @Autowired
    public PassengerService(PassengerRepository passengerRepository) {
        this.passengerRepository = passengerRepository;
    }

    public void saveUser(Passenger p){
        passengerRepository.save(p);
    }

    public PassengerDto getProvisionsByPassengerID(String PID){
        Passenger passenger = passengerRepository.findById(PID).orElseThrow(
                RuntimeException::new
        );


        PassengerDto response = new PassengerDto();
        ActiveProvisionDto activeProvisionDto = new ActiveProvisionDto();
        UsedProvisionDto usedProvisionDto = new UsedProvisionDto();

        return response;
    }
}
