//
//  ServerData.swift
//  application
//
//  Created by Betul on 4/24/23.
//

import Foundation

struct ServerData: Codable {
    let passengerId, passengerName, passengerSurname, passengerEmail, passengerAddress: String
    let passengerPhoneNumber, amount, provisionDate, aid: String
}
