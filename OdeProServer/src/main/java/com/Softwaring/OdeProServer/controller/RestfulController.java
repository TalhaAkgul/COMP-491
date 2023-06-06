package com.Softwaring.OdeProServer.controller;

import com.Softwaring.OdeProServer.dto.*;
import com.Softwaring.OdeProServer.exception.NotFoundException;
import com.Softwaring.OdeProServer.service.OdeProService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@CrossOrigin(origins = "*")
@RestController
@AllArgsConstructor
@Slf4j
public class RestfulController {
    private final OdeProService odeProService;

    @GetMapping("/getActiveProvision")
    public ResponseEntity<?> getActiveProvisionsByPID(@RequestParam("id") String PID) {
        try {
            log.info("Request for getActiveProvisionsByPID is received for PID: " + PID);
            List<ActiveProvisionDTO> results = new ArrayList<>();
            results.add(odeProService.getActiveProvisionByPassengerID(PID));
            return ResponseEntity.ok(results);
        } catch (NotFoundException e) {
            log.warn(e.getMessage());
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

    @GetMapping("/getProvisionsByFlightNo")
    public ResponseEntity<?> getActiveProvisionsByFlightNo(@RequestParam("flightNo") String flightNo) {
        try {
            log.info("Request for getActiveProvisionsByFlightNo is received for flightNo: " + flightNo);
            List<ActiveProvisionDTO> results = odeProService.getActiveProvisionByFlightNo(flightNo);
            return ResponseEntity.ok(results);
        } catch (NotFoundException e) {
            log.warn(e.getMessage());
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

    @GetMapping("/getUsedProvisions")
    public ResponseEntity<?> getUsedProvisions(@RequestParam("id") String PID) {
        try {
            log.info("Request for getUsedProvisions is received for PID: " + PID);
            List<UsedProvisionDTO> results = odeProService.getUsedProvisionsByPassengerID(PID);
            return ResponseEntity.ok(results);
        } catch (NotFoundException e) {
            log.warn(e.getMessage());
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

    @PostMapping("/getPassenger")
    public ResponseEntity<?> checkPassenger(@RequestBody final String PID) {
        try {
            PassengerDTO passengerDTO = odeProService.getPassenger(PID);
            return ResponseEntity.ok(passengerDTO);
        } catch (NotFoundException e) {
            log.warn(e.getMessage());
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

    @GetMapping("/deleteActiveProvision")
    public ResponseEntity<String> deleteActiveProvision(@RequestParam("id") String PID) {
        try {
            log.info("Request for deleteActiveProvision is received for PID: " + PID);
            odeProService.deleteActiveProvision(PID);
            return ResponseEntity.ok("Passenger with id: " + PID + " deleted");
        } catch (NotFoundException e) {
            log.error(e.getMessage());
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

    @PostMapping("/addPassenger")
    public ResponseEntity<?> addPassenger(@RequestBody final PassengerDTO passenger) {
        try {
            log.info("Request for deleteActiveProvision is received for PID: " + passenger.getPID());
            odeProService.addPassenger(passenger);
            return ResponseEntity.ok(passenger);
        } catch (IllegalArgumentException e) {
            log.error(e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @PostMapping("/payment")
    public ResponseEntity<?> openProvision(@RequestBody final OpenProvisionDTO openProvision) {
        try {
            log.info("Request for openProvision is received for PID: " + openProvision.getPassengerPID());
            odeProService.openProvision(openProvision);
            return ResponseEntity.ok("Provision is opened");
        } catch (Exception e) {
            log.error(e.getMessage());
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        }
    }

    @PostMapping("/close")
    public ResponseEntity<?> closeProvision(@RequestBody final CloseProvisionRequest closeProvisionRequest) {
        try {
            log.info("Request for closeProvision is received for flightNo: " + closeProvisionRequest.getFlightNo());
            odeProService.closeProvision(closeProvisionRequest);
            return ResponseEntity.ok("Provision is closed");
        } catch (Exception e) {
            log.error(e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }
}
