package com.Softwaring.OdeProServer.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.*;
import org.springframework.context.annotation.Primary;


@Entity
@Table(name = "passenger")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Passenger {
    @Id
    @Column(name = "PID", nullable = false)
    private String PID = "";

    @Column(name = "name", nullable = false)
    private String name = "";

    @Column(name = "surname", nullable = false)
    private String surname = "";

    @Column(name = "email", nullable = false)
    private String email = "";

    @Column(name = "address")
    private String address = "";

    @Column(name = "phone_number", length = 13)
    private String phoneNumber = "";
}
