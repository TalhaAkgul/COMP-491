package com.Softwaring.OdeProServer.controller;

import com.Softwaring.OdeProServer.dto.*;
import com.Softwaring.OdeProServer.entity.Passenger;
import com.Softwaring.OdeProServer.exception.NotFoundException;
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

    @GetMapping("/getActiveProvision")
    public ResponseEntity<?> getActiveProvisionsByPID(@RequestParam("id") String PID) {
        try {
            System.out.println(PID);
            List<ActiveProvisionDTO> results = new ArrayList<>();
            results.add(passengerService.getActiveProvisionByPassengerID(PID));
            System.out.println();
            return ResponseEntity.ok(results);
        } catch (NotFoundException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

    @GetMapping("/getProvisionsByFlightNo")
    public ResponseEntity<?> getActiveProvisionsByFlightNo(@RequestParam("flightNo") String flightNo) {
        try {
            System.out.println(flightNo);
            List<ActiveProvisionDTO> results = passengerService.getActiveProvisionByFlightNo(flightNo);
            return ResponseEntity.ok(results);
        } catch (NotFoundException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }
    @GetMapping("/getUsedProvisions")
    public ResponseEntity<?> getUsedProvisions(@RequestParam("id") String PID) {
        try {
            List<UsedProvisionDTO> results = passengerService.getUsedProvisionsByPassengerID(PID);
            System.out.println(results);
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

    @GetMapping("/deleteActiveProvision")
    public ResponseEntity<String> search(@RequestParam("id") String PID) {
        try {
            System.out.println("PIDDDDD: "+PID);
            passengerService.deleteActiveProvision(PID);
            return ResponseEntity.ok("Passenger with id: " + PID + " deleted");
        } catch (NotFoundException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

    @PostMapping("/addPassenger")
    public ResponseEntity<?> addPassenger(@RequestBody final PassengerDTO passenger) {
        try {
            passengerService.addPassenger(passenger);
            return ResponseEntity.ok(passenger);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @PostMapping("/payment")//TODO You can try ResponseEntity<String>
    public ResponseEntity<?> addPassenger(@RequestBody final OpenProvisionDTO openProvision) {
        try {
            System.out.println(openProvision);
            passengerService.openProvision(openProvision);
            return ResponseEntity.ok("Provision is opened");
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

    @PostMapping("/close")
    public ResponseEntity<?> closeProvision(@RequestBody final CloseProvisionRequest closeProvisionRequest) {
        try {
            passengerService.closeProvision(closeProvisionRequest);
            System.out.println(closeProvisionRequest);

            return ResponseEntity.ok("Provision is closed");
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }
}
