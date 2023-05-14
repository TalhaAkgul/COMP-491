package com.Softwaring.OdeProServer.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PassengerDTO {
    String PID;
    String name;
    String surname;
    String email;
    String address;
    String phoneNumber;
}
