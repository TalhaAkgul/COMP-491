package com.Softwaring.OdeProServer.controller;

import com.Softwaring.OdeProServer.dto.ActiveProvisionDTO;
import com.Softwaring.OdeProServer.dto.PassengerDTO;
import com.Softwaring.OdeProServer.dto.OpenProvisionDTO;
import com.Softwaring.OdeProServer.dto.UsedProvisionDTO;
import com.Softwaring.OdeProServer.entity.Passenger;
import com.Softwaring.OdeProServer.exception.NotFoundException;
import com.Softwaring.OdeProServer.service.BankService;
import com.Softwaring.OdeProServer.service.PassengerService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@CrossOrigin(origins = "*")
@RestController
@AllArgsConstructor
public class RestfulController {


    private final PassengerService passengerService;
    private final BankService bankService;


    private List<Passenger> allUsers() {
        ArrayList<Passenger> list = new ArrayList<Passenger>();

        System.out.println(list);
/*
        passengerService.saveUser(b);
        activeProvision1.setAID("2");
        activeProvision1.setAmount(123);
        activeProvision1.setFlightNo("21324");
        activeProvision1.setProvisionDate(now);
        activeProvision1.setPassenger(a);
        activeProvision1.setUniqueCardId("2");

        activeProvision2.setAID("3");
        activeProvision2.setAmount(323456);
        activeProvision2.setFlightNo("23455");
        activeProvision2.setProvisionDate(now);
        activeProvision2.setPassenger(b);
        activeProvision2.setUniqueCardId("2345");

        activeProvisionRepository.save(activeProvision2);
        usedProvisionRepository.save(usedProvision1);
        transactionsRepository.save(transactions1);
*/
        return list;
    }

    @GetMapping("/getalldata")
    public List<Passenger> hello() {
        return allUsers();
    }

    @PostMapping("/getActiveProvision")
    public ResponseEntity<?> getActiveProvisions(@RequestBody final String PID) {
        try {
            ActiveProvisionDTO result = passengerService.getActiveProvisionByPassengerID(PID);
            return ResponseEntity.ok(result);
        } catch (NotFoundException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

    @PostMapping("/getUsedProvisions")
    public ResponseEntity<?> getUsedProvisions(@RequestBody final String PID) {
        try {
            List<UsedProvisionDTO> results = passengerService.getUsedProvisionsByPassengerID(PID);
            return ResponseEntity.ok(results);
        } catch (NotFoundException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

    @PostMapping("/getPassenger")
    public ResponseEntity<?> checkPassenger(@RequestBody final String PID) {
        try {
            PassengerDTO passengerDTO = passengerService.getPassenger(PID);
            return ResponseEntity.ok(passengerDTO);
        } catch (NotFoundException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

    @GetMapping("/search")
    public ActiveProvisionDTO search() {

        return passengerService.getProvisionsByPassengerID("1");
    }


    @PostMapping("/product")
    public String createProduct(@RequestBody final Passenger user) {
        System.out.println("user");
        return "Empty";
    }

    @PostMapping("/addPassenger")
    public ResponseEntity<?> addPassenger(@RequestBody final PassengerDTO passenger){
        try {
            passengerService.addPassenger(passenger);
            return ResponseEntity.ok(passenger);
        }catch (IllegalArgumentException e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }
    @PostMapping("/payment")
    public ResponseEntity<?> addPassenger(@RequestBody final OpenProvisionDTO openProvision){
        try {
            bankService.openProvision(openProvision);
            return ResponseEntity.ok("Provision is opened");
        }catch (IllegalArgumentException e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }
}
