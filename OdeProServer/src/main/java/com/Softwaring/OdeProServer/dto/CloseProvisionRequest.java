package com.Softwaring.OdeProServer.dto;

import lombok.Data;

import java.util.List;

@Data
public class CloseProvisionRequest {
    String flightNo;
    List<TransactionDTO> transactions;
}
