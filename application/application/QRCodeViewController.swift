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
import MultipeerConnectivity


class QRCodeViewController: UIViewController {
    let sessionManager = SessionManager.shared
    var mcSession: MCSession!
    var scannedCode: String = ""
    var scanComplete: Bool = false {
        didSet {
            processDataFromQRCode()
            movePersonalDetailsPage()
        }
    }
    
    func retrieveTransactionsFromConnectedDevices(){
        sessionManager.sendSyncRequest()
    }
    let databaseController = DatabaseController.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseController.connectMenuDatabase()
        databaseController.connectQRDatabase()
        mcSession = self.sessionManager.mcSession
        retrieveTransactionsFromConnectedDevices()
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
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height
        let scanView = UIHostingController(rootView: scannerSheet)
       
        //scanView.view.frame = self.view.bounds
        
        
        let navigationItem = UINavigationItem(title: "Scan QR Code")
        let back = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                   style: .plain,
                                   target: self,
                                   action: #selector(goBack))
        navigationItem.leftBarButtonItem = back

        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: screenHeight/25, width: view.frame.width, height: 44))
        navigationBar.barTintColor = self.view.backgroundColor
        navigationBar.setItems([navigationItem], animated: false)
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.tintColor = .blue
        navigationBar.backgroundColor = .clear
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        scanView.view.frame = CGRect(x: 0, y: screenHeight/25 + navigationBar.frame.height, width: view.frame.width, height: view.frame.height - (screenHeight/25 + navigationBar.frame.height))

        view.addSubview(navigationBar)
        self.view.addSubview(scanView.view)
        self.addChild(scanView)
    }
    
    @objc func goBack() {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "mainViewController") {
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true, completion: nil)
        }
    }
    
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
            orderDict = passengerInfo.orders
            
            if orderDict.isEmpty {
                let insertQuery = databaseController.qrTable.insert(databaseController.pId <- passID, databaseController.prId <- String(-1), databaseController.prCount <- String(-1))
                do {
                    try databaseController.database3.run(insertQuery)
                } catch {
                    print("Error inserting data: \(error)")
                }
            }
             
            for dict in orderDict {
                let prIdValue = dict.keys.first ?? ""
                let prCountValue = dict.values.first ?? ""
                let insertQuery = databaseController.qrTable.insert(databaseController.pId <- passID, databaseController.prId <- prIdValue, databaseController.prCount <- prCountValue)
                if let prId = Int(prIdValue) {
                    let matchingRow = databaseController.productsTable.filter(databaseController.productId == prId)
                    if let prCountString = dict.values.first, let prCountValue = Int(prCountString) {
                        let updateStatement = matchingRow.update(databaseController.count <- prCountValue)

                        do {
                            try databaseController.database.run(updateStatement)
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
                    try databaseController.database3.run(insertQuery)
                } catch {
                    print("Error inserting data: \(error)")
                }
            }
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
    
    
    
}





