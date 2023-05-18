package com.Softwaring.OdeProServer.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "transactions")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
@ToString
public class Transactions {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "TID", nullable = false)
    private Long TID;

    @Column(name = "amount", nullable = false)
    private int amount;

    @ManyToOne
    @JoinColumn(name = "AID")//TODO Check whether you can delete this or not
    private ActiveProvision activeProvision;
}
