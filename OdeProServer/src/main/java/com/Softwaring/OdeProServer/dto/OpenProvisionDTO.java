package com.Softwaring.OdeProServer.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OpenProvisionDTO {
    String passengerPID;
    String passengerName;
    String passengerSurname;
    String passengerEmail;
    String passengerAddress;
    String passengerPhoneNumber;
    double amount;
    String flightNo;
    String creditCardNo;
    String cardHolder;
    String expiration;
    String cvc;
}
