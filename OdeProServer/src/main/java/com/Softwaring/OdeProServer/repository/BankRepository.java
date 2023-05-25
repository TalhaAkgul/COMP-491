package com.Softwaring.OdeProServer.repository;

import com.Softwaring.OdeProServer.entity.Bank;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface BankRepository extends JpaRepository<Bank, String> {
    Optional<Bank> findByCreditCardNoAndCardHolderAndExpirationAndCvc(String creditCardNo, String cardHolder, String expiration, String cvv);

    Optional<Bank> findByUniqueCardId(String uniqueCardId);
}
