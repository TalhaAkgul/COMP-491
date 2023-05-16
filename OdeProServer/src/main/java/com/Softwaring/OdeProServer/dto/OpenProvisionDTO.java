package com.Softwaring.OdeProServer.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

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
    String AID;
    String amount;
    String provisionDate;
    String flightNo;
    String cardNumber;
    String cardHolderName;
    String expirationDate;
    String cvc;
}
