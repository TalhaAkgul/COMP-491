//
//  QRJSONData.swift
//  application
//
//  Created by Doga Ege Inhanli on 16.04.2023.
//

import Foundation

struct PassengerInfo: Codable {
    let orders: [[String: String]]
    let passengerID: String
}

