package com.Softwaring.OdeProServer.repository;

import com.Softwaring.OdeProServer.entity.Transactions;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TransactionsRepository extends JpaRepository<Transactions, String> {
}
