//
//  TransactionJSONData.swift
//  application
//
//  Created by Doga Ege Inhanli on 12.05.2023.
//

import Foundation

struct TransactionJSONData: Codable {
    let transactionId: String
    let amount: Double
    let passengerId: String
}
