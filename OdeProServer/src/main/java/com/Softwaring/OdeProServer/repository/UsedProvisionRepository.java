package com.Softwaring.OdeProServer.repository;

import com.Softwaring.OdeProServer.entity.Passenger;
import com.Softwaring.OdeProServer.entity.UsedProvision;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UsedProvisionRepository extends JpaRepository<UsedProvision, String> {
    Optional<List<UsedProvision>> findByPassenger(Passenger passenger);

    Optional<List<UsedProvision>> findByPassenger_PID(String PID);
}