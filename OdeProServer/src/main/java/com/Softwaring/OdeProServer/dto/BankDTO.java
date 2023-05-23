package com.Softwaring.OdeProServer.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BankDTO {
    String creditCardNo;
    String cardHolder;
    String expiration;
    String cvc;

    @Override
    public String toString() {
        return String.format("creditCardNo=%s, cardHolder=%s, expiration=%s, cvc=%s",
                creditCardNo, cardHolder, expiration, cvc);
    }
}
