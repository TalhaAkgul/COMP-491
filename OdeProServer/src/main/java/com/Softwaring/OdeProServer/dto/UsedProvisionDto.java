package com.Softwaring.OdeProServer.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UsedProvisionDto {
    private int amount;
    private Timestamp provisionDate;
    private String flightNo;
}
