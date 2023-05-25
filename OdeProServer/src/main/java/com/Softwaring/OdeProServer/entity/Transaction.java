package com.Softwaring.OdeProServer.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "transaction")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
@ToString
public class Transaction {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "TID", nullable = false)
    private Long TID;

    @Column(name = "amount", nullable = false)
    private double amount;

    @Column(name = "ProvID")
    private Long provID;
}
