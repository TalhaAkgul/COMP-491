package com.Softwaring.OdeProServer.entity;

import jakarta.persistence.*;
import lombok.*;

import java.sql.Timestamp;

@Entity
@Table(name = "activeprovision")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
@ToString
public class ActiveProvision {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "AID", nullable = false)
    private Long AID;

    @Column(name = "amount", nullable = false)
    private double amount;

    @Column(name = "provision_date", nullable = false)
    private Timestamp provisionDate;

    @Column(name = "flight_no", nullable = false)
    private String flightNo = "";

    @OneToOne
    @JoinColumn(name = "PID")
    private Passenger passenger;

    @Column(name = "unique_card_id", nullable = false)
    private String uniqueCardId = "";
}
