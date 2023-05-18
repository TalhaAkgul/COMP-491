package com.Softwaring.OdeProServer.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.*;

@Entity
@Table(name = "bank")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode
@ToString
public class Bank {
    @Id
    @Column(name = "unique_card_id", nullable = false)
    private String uniqueCardId;

    @Column(name = "credit_card_no", length = 16, nullable = false)
    private String creditCardNo;

    @Column(name = "card_holder", nullable = false)
    private String cardHolder;

    @Column(name = "credit_limit", nullable = false)
    private double creditLimit;

    @Column(name = "expiration", length = 5, nullable = false)
    private String expiration;

    @Column(name = "cvc", length = 3, nullable = false)
    private String cvc;
}
