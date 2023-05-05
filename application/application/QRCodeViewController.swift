//
//  QRCodeViewController.swift
//  application
//
//  Created by Doga Ege Inhanli on 29.03.2023.
//

import UIKit
import SwiftUI
import CodeScanner
import SQLite


class QRCodeViewController: UIViewController {
    
    var database: Connection!
    let productsTable = Table("Products")
    let productId = Expression<Int>("productId")
    let productName = Expression<String>("productName")
    let productType = Expression<String>("productType")
    let count = Expression<Int>("count")
    let price = Expression<Double>("price")
    
    var scannedCode: String = ""
    var scanComplete: Bool = false {
        didSet {
            processDataFromQRCode()
            movePersonalDetailsPage()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        var scannerSheet : CodeScannerView {
            CodeScannerView(
                codeTypes: [.qr],
                completion: {result in
                    if case let .success(code) = result{
                        self.scannedCode = code.string
                        self.scanComplete = true
                    }
                }
            )
        }
        
        let scanView = UIHostingController(rootView: scannerSheet)
        scanView.view.frame = self.view.bounds
        self.view.addSubview(scanView.view)
        self.addChild(scanView)
        connectDatabase()
        connectDatabase3()
        
        
    }
    
    var database3: Connection!
    let qrTable = Table("QR")
    let pId = Expression<String>("pId")
    let prId = Expression<String>("prId")
    let prCount = Expression<String>("prCount")
    
    
    
    func processDataFromQRCode() {
        var passID = ""
        var orderDict : [[String: String]]
        let passengerInfoAsJsonData = self.scannedCode.data(using: .utf8)!

        do {
          let decoder = JSONDecoder()
          let passengerInfo = try decoder.decode(PassengerInfo.self, from: passengerInfoAsJsonData)
            let passIDWithZeros = passengerInfo.passengerID
            let start = passIDWithZeros.index(passIDWithZeros.startIndex, offsetBy: 4)
            let end = passIDWithZeros.index(passIDWithZeros.endIndex, offsetBy: (-1))
            let range = start...end
            passID = String(passIDWithZeros[range])
            print(passID)
            orderDict = passengerInfo.orders
            print(orderDict)
            for dict in orderDict {
                let prIdValue = dict.keys.first ?? ""
                let prCountValue = dict.values.first ?? ""
                let insertQuery = qrTable.insert(pId <- passID, prId <- prIdValue, prCount <- prCountValue)
                if let prId = Int(prIdValue) {
                    let matchingRow = productsTable.filter(productId == prId)
                    if let prCountString = dict.values.first, let prCountValue = Int(prCountString) {
                        let updateStatement = matchingRow.update(count <- prCountValue)

                        do {
                            try database.run(updateStatement)
                            print("Successfully updated count value")
                        } catch {
                            print("Error updating count value: \(error)")
                        }
                    } else {
                        print("Error: Invalid count value")
                    }
                } else {
                    print("Error: Invalid product ID value")
                }
                
                do {
                    try database3.run(insertQuery)
                } catch {
                    print("Error inserting data: \(error)")
                }
            }
            /*
            let selectQuery = qrTable.select(*)
            do {
                for row in try database3.prepare(selectQuery) {
                    let pIdValue = row[pId]
                    let prIdValue = row[prId]
                    let prCountValue = row[prCount]
                    
                    print("pId: \(pIdValue), prId: \(prIdValue), prCount: \(prCountValue)")
                }
            } catch {
                print("Error selecting data: \(error)")
            }
             */
            /*
                    print("LIST TAPPED")
                            
                            do {
                                let users = try self.database3.prepare(self.qrTable)
                                for user in users {
                                    print("userId: \(user[self.id]), name: \(user[self.name]), email: \(user[self.email])")
                                }
                            } catch {
                                print(error)
                            }
             */
        } catch {
          print(error)
        }
    }
    
    func movePersonalDetailsPage(){
        let personalDetailsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PersonalDetailsController") as! PersonalDetailsController
        self.addChild(personalDetailsController)
        personalDetailsController.view.frame = self.view.frame
        self.view.addSubview(personalDetailsController.view)
        personalDetailsController.didMove(toParent: self)
    }
    func connectDatabase3(){
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("QR").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database3 = database
        } catch {
            print(error)
        }
    }
    
    func connectDatabase(){
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("Products").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch {
            print(error)
        }
    }
}





