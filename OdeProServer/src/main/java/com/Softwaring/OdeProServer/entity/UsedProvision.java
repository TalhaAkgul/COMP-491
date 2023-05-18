package com.Softwaring.OdeProServer.entity;

import jakarta.persistence.*;
import lombok.*;

import java.sql.Timestamp;

@Entity
@Table(name = "usedprovision")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
@ToString
public class UsedProvision {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "UID", nullable = false)
    private Long UID;

    @Column(name = "amount", nullable = false)
    private int amount;

    @Column(name = "provision_date", nullable = false)
    private Timestamp provisionDate;

    @Column(name = "flight_no", nullable = false)
    private String flightNo = "";

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "PID")
    private Passenger passenger;

    @Column(name = "unique_card_id")
    private String uniqueCardId;
}
