package com.Softwaring.OdeProServer.repository;

import com.Softwaring.OdeProServer.entity.ActiveProvision;
import com.Softwaring.OdeProServer.entity.Passenger;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface ActiveProvisionRepository extends JpaRepository<ActiveProvision, String> {
    Optional<ActiveProvision> findByPassenger(Passenger passenger);

    Optional<ActiveProvision> findByPassenger_PID(String PID);

    void deleteActiveProvisionByPassenger_PID(String PID);

    Optional<List<ActiveProvision>> findByFlightNo(String flightNo);
}
