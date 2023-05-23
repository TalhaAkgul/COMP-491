package com.Softwaring.OdeProServer.repository;

import com.Softwaring.OdeProServer.entity.Passenger;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface PassengerRepository extends JpaRepository<Passenger, String> {
    Optional<Passenger> findByPID(String PID);
}
