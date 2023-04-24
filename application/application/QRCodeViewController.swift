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
                        //print(code)
                        //print(code.string)
                        self.scannedCode = code.string
                        self.scanComplete = true
                        //print(self.scannedCode)
                    }
                }
            )
        }
        
        let scanView = UIHostingController(rootView: scannerSheet)
        //scanView.view.translatesAutoresizingMaskIntoConstraints = false
        scanView.view.frame = self.view.bounds
        self.view.addSubview(scanView.view)
        self.addChild(scanView)
        connectDatabase()
        
        
    }
    
    var database3: Connection!
    let qrTable = Table("QR")
    let pId = Expression<String>("pId")
    let prId = Expression<String>("prId")
    let prCount = Expression<String>("prCount")
    
    
    
    func processDataFromQRCode() {
        //var dictonary:NSDictionary?
        var passID = ""
        //var orderDict = ""
        var orderDict : [[String: String]]
        //print("AAAA")
        /*
        if let data = self.scannedCode.data(using: String.Encoding.utf8) {
            do {
                
                dictonary = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] as NSDictionary?
                    
                if let myDictionary = dictonary {
                    //Passenger ID
                    let passIDWithZeros = "\(myDictionary["passengerID"]!)"
                    let start = passIDWithZeros.index(passIDWithZeros.startIndex, offsetBy: 4)
                    let end = passIDWithZeros.index(passIDWithZeros.endIndex, offsetBy: (-1))
                    let range = start...end
                    passID = String(passIDWithZeros[range])
                    print(passID)
                    //print(" First name is: \(myDictionary["passengerID"]!)")
                    
                    //Orders
                    orderDict = "\(myDictionary["orders"]!)"
                    print(orderDict)
                }
            } catch let error as NSError {
                print(error)
            }
        }
         */
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
            //print(passID)
            //print(passengerInfo)
            
            for dict in orderDict {
                let prIdValue = dict.keys.first ?? ""
                let prCountValue = dict.values.first ?? ""
                
                let insertQuery = qrTable.insert(pId <- passID, prId <- prIdValue, prCount <- prCountValue)
                
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
    func connectDatabase(){
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("QR").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database3 = database
        } catch {
            print(error)
        }
    }
}





