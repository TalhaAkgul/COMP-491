//
//  QRCodePageController.swift
//  QRCodeApplication
//
//  Created by Doga Ege Inhanli on 11.04.2023.
//

import UIKit
import PassKit
import SQLite
import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

class QRCodePageController: UIViewController {
    
    var database: Connection!
    let productsTable = Table("Products")
    let productId = Expression<Int>("productId")
    let productName = Expression<String>("productName")
    let productType = Expression<String>("productType")
    let count = Expression<Int>("count")
    let price = Expression<Double>("price")
    
    let customerTable = Table("Passenger")
    let passId = Expression<String>("passId")
    @IBOutlet weak var qrCodeImageView: UIImageView!
    let filter = CIFilter.qrCodeGenerator()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        showAnimate()
        let str = "dskds"
        generateQRCode(Data: str)
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
    func generateQRCode(Data:String){
        let orderDict : [String: Any] = generateJSON()
        
        //let data = Data.data(using: String.Encoding.ascii, allowLossyConversion: false)
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: orderDict, options: [.prettyPrinted]) else {
            return
        }
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(jsonData, forKey: "InputMessage")
        
        
        //filter.setValue(data, forKey: "InputMessage")
        
        let ciImage = filter?.outputImage
        
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let transformImage = ciImage?.transformed(by: transform)
        
        let image = UIImage(ciImage: transformImage!)
        qrCodeImageView.image = image
        print(orderDict)
    }
    
    func generateJSON() -> [String: Any]{
        connectDatabase()
        var orderDict : [String: Any] = [ "passengerID": "", "orders": [ ], ]
        var passID = ""
        do{
            let passengers = try self.database.prepare(self.customerTable)
            for passenger in passengers {
                passID = String(passenger[self.passId])
            }
        } catch {
            print(error)
        }
        orderDict.updateValue(passID, forKey: "passengerID")
        var orderArray:[[String:String]] = []
        do {
            let products = try self.database.prepare(self.productsTable.filter(self.count > 0))
            for product in products {
                orderArray.append([String(product[self.productId]): String(product[self.count])])
            }
        } catch {
            print(error)
        }
        orderDict.updateValue(orderArray, forKey: "orders")
        return orderDict
    }
    
    @IBAction func closeClicked(_ sender: UIButton) {
        removeAnimate()
    }
    
    @IBAction func addWalletClicked(_ sender: UIButton) {
        
    }
    
   
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.view.removeFromSuperview()
                }
        });
    }
}
