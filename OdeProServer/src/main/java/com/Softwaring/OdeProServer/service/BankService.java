package com.Softwaring.OdeProServer.service;

import com.Softwaring.OdeProServer.dto.BankDTO;
import com.Softwaring.OdeProServer.entity.Bank;
import com.Softwaring.OdeProServer.exception.NotFoundException;
import com.Softwaring.OdeProServer.repository.BankRepository;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
@Slf4j
public class BankService {
    private BankRepository bankRepository;

    public String openProvision(BankDTO bankDTO, double amount) {
        Bank bank = bankRepository.findByCreditCardNoAndCardHolderAndExpirationAndCvc(
                        bankDTO.getCreditCardNo(),
                        bankDTO.getCardHolder(),
                        bankDTO.getExpiration(),
                        bankDTO.getCvc()
                )
                .orElseThrow(() -> {
                    String error = "Bank could not found data for " + bankDTO.getCardHolder() + " with card number: **** " + bankDTO.getCreditCardNo().substring(12, 16);
                    return new NotFoundException(error);
                });
        if (amount > bank.getCreditLimit()) throw new NotFoundException(
                "Bank states that there is insufficient limit for " +
                        bankDTO.getCardHolder() + " with card number: **** " + bankDTO.getCreditCardNo().substring(12, 16));
        bank.setCreditLimit(bank.getCreditLimit() - amount);
        bankRepository.save(bank);
        log.info("Bank is opened provision for CardHolder: " + bankDTO.getCardHolder());
        return bank.getUniqueCardId();
    }

    public String getHiddenCardNo(String uniqueCardId) {
        Bank bank = bankRepository.findByUniqueCardId(uniqueCardId)
                .orElseThrow(() -> new NotFoundException(Bank.class, "states that there is no card info for user ->", "classified info"));
        String cardNumber = bank.getCreditCardNo();
        return "**** " + cardNumber.substring(12, 16);
    }

    public void closeProvision(String uniqueCardId, double amount) {
        Bank bank = bankRepository.findByUniqueCardId(uniqueCardId)
                .orElseThrow(() -> new NotFoundException(Bank.class, "states that there is no card info for user ->", "classified info"));
        bank.setCreditLimit(bank.getCreditLimit() + amount);
        log.info("Bank is closed the provision for CardHolder: " + bank.getCardHolder());
    }
}
