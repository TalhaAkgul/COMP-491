package com.Softwaring.OdeProServer.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "transactions")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Transactions {
    @Id
    @Column(name = "TID", nullable = false)
    private String TID = "";

    @Column(name = "amount", nullable = false)
    private int amount;

    @ManyToOne
    @JoinColumn(name = "AID")//TODO Check whether you can delete this or not
    private ActiveProvision activeProvision;
}
