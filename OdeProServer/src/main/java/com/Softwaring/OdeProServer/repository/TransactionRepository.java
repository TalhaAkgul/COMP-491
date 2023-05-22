package com.Softwaring.OdeProServer.repository;

import com.Softwaring.OdeProServer.entity.Transaction;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TransactionRepository extends JpaRepository<Transaction, String> {
}
