package com.Softwaring.OdeProServer.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
import java.time.Instant;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UsedProvisionDTO {
    String passengerPID;
    String passengerName;
    String passengerSurname;
    String passengerEmail;
    String passengerAddress;
    String passengerPhoneNumber;
    double amount;
    String provisionDate;
    String flightNo;
    String hiddenCardNo;
}
