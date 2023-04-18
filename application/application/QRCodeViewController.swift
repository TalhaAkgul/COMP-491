//
//  QRCodeViewController.swift
//  application
//
//  Created by Doga Ege Inhanli on 29.03.2023.
//

import UIKit
import SwiftUI
import CodeScanner

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
        var scannerSheet : some View {
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
        
        
    }
    
    func processDataFromQRCode() {
        //var dictonary:NSDictionary?
        var passID = ""
        //var orderDict = ""
        var orderDict : [[String: Any]]
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
            //print(passID)
            orderDict = passengerInfo.orders
            //print(orderDict)
            //print(passID)
            //print(passengerInfo)
            /*
            for elem in orderDict{
                print(elem.keys)
                print(elem.values)
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
}





