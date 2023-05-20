package com.Softwaring.OdeProServer.dto;

import lombok.Data;

import java.util.List;

@Data
public class CloseProvisionRequest {
    private List<ActiveProvisionDTO> activeProvision;
    private List<TransactionsDTO> transactions;
}
