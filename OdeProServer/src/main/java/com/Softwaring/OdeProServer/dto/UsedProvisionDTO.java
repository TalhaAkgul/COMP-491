package com.Softwaring.OdeProServer.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

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
    String UID;
    String amount;
    String provisionDate;
}
