package com.Softwaring.OdeProServer.dto;

import jakarta.persistence.Column;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PassengerDto {
    private String PID;
    private String name = "";
    private String surname = "";
    private ActiveProvisionDto activeProvisionDto;
    private List<UsedProvisionDto> usedProvisionDto;
}
