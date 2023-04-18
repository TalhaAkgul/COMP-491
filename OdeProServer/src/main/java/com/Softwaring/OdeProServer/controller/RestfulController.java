package com.Softwaring.OdeProServer.controller;

import com.Softwaring.OdeProServer.dto.PassengerDto;
import com.Softwaring.OdeProServer.entity.ActiveProvision;
import com.Softwaring.OdeProServer.entity.Passenger;
import com.Softwaring.OdeProServer.entity.Transactions;
import com.Softwaring.OdeProServer.entity.UsedProvision;
import com.Softwaring.OdeProServer.repository.ActiveProvisionRepository;
import com.Softwaring.OdeProServer.repository.PassengerRepository;
import com.Softwaring.OdeProServer.repository.TransactionsRepository;
import com.Softwaring.OdeProServer.repository.UsedProvisionRepository;
import com.Softwaring.OdeProServer.service.PassengerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

@CrossOrigin(origins = "*")
@RestController
public class RestfulController {

    Timestamp now = new Timestamp(Calendar.getInstance().getTimeInMillis());
    Passenger a = new Passenger("1", "Pınar", "Erbil", "24@gmail.com", "Ankara", "1234567894561");
    Passenger b = new Passenger("2", "Ahmet Talha", "Akgül", "13@gmail.com", "İstanbul", "TK7350");
    Passenger c = new Passenger("3", "Lewis", "Hamilton", "44@gmail.com", "London", "TK44");
    Passenger d = new Passenger("4", "Hatice", "LLL", "34@gmail.com", "Paris", "TK7350");
    ActiveProvision activeProvision1 = new ActiveProvision();
    UsedProvision usedProvision1 = new UsedProvision("1", 1234, now, "TK321", a);
    Transactions transactions1 = new Transactions("1", 12345, activeProvision1);
    private ActiveProvisionRepository activeProvisionRepository;
    private UsedProvisionRepository usedProvisionRepository;
    private TransactionsRepository transactionsRepository;

    private PassengerService passengerService;

    @Autowired
    public RestfulController(PassengerService passengerService,
                             ActiveProvisionRepository activeProvisionRepository,
                             UsedProvisionRepository usedProvisionRepository,
                             TransactionsRepository transactionsRepository) {
        this.passengerService = passengerService;
        this.transactionsRepository = transactionsRepository;
        this.activeProvisionRepository = activeProvisionRepository;
        this.usedProvisionRepository = usedProvisionRepository;
    }

    private List<Passenger> allUsers() {
        ArrayList<Passenger> list = new ArrayList<Passenger>();
        list.add(a);
        list.add(b);
        list.add(c);
        list.add(d);
        System.out.println(list);
        passengerService.saveUser(a);
        activeProvision1.setAID("1");
        activeProvision1.setAmount(123);
        activeProvision1.setFlightNo("21324");
        activeProvision1.setProvisionDate(now);
        activeProvision1.setPassenger(a);
        activeProvision1.setUniqueCardId("2");
        activeProvisionRepository.save(activeProvision1);
        usedProvisionRepository.save(usedProvision1);
        transactionsRepository.save(transactions1);
        return list;
    }

    @GetMapping("/getalldata")
    public List<Passenger> hello() {
        return allUsers();
    }

    @PostMapping("/product")
    public String createProduct(@RequestBody final Passenger user) {
        System.out.println("user");
        return "Empty";
    }

    @PostMapping("/get")
    public ResponseEntity<PassengerDto> getPassenger(@RequestBody String id) {

        PassengerDto a = new PassengerDto();
        return ResponseEntity.ok().body(a);
    }

    @PostMapping("/deneme")
    public ResponseEntity deneme(@RequestBody String a) {
        System.out.println(a);

        return ResponseEntity.ok(HttpStatus.OK);
    }
}
