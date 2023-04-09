//
//  AfterFlightServiceController.swift
//  application
//
//  Created by Doga Ege Inhanli on 3.04.2023.
//

import UIKit
import SQLite

class AfterFlightServicesController: UIViewController {
    
    var database: Connection!
    let productsTable = Table("Products")
    let productId = Expression<Int>("productId")
    let productName = Expression<String>("productName")
    let productType = Expression<String>("productType")
    let count = Expression<Int>("count")
    let price = Expression<Double>("price")
    
    @IBOutlet weak var aftPhoto1: UIImageView!
    @IBOutlet weak var aftPhoto2: UIImageView!
    @IBOutlet weak var aftPhoto3: UIImageView!
    @IBOutlet weak var aftPhoto4: UIImageView!
    @IBOutlet weak var aftPhoto5: UIImageView!
    
    @IBOutlet weak var plusButton1: UIButton!
    @IBOutlet weak var plusButton2: UIButton!
    @IBOutlet weak var plusButton3: UIButton!
    @IBOutlet weak var plusButton4: UIButton!
    @IBOutlet weak var plusButton5: UIButton!
    
    @IBOutlet weak var minusButton1: UIButton!
    @IBOutlet weak var minusButton2: UIButton!
    @IBOutlet weak var minusButton3: UIButton!
    @IBOutlet weak var minusButton4: UIButton!
    @IBOutlet weak var minusButton5: UIButton!
    
    @IBOutlet weak var count1: UILabel!
    @IBOutlet weak var count2: UILabel!
    @IBOutlet weak var count3: UILabel!
    @IBOutlet weak var count4: UILabel!
    @IBOutlet weak var count5: UILabel!
    
    var countLabels = [UILabel]()
    var plusButtons = [UIButton]()
    var minusButtons = [UIButton]()
    override func viewDidLoad() {
        super.viewDidLoad()
        connectDatabase()
        aftPhoto1.image = UIImage(named: "images/afterflight menu images/Blue and Orange Game Time Instagram Post.png")
        aftPhoto2.image = UIImage(named: "images/afterflight menu images/Blue and Orange Game Time Instagram Post-2.jpg")
        aftPhoto3.image = UIImage(named: "images/afterflight menu images/Blue and Orange Game Time Instagram Post-3.jpg")
        aftPhoto4.image = UIImage(named: "images/afterflight menu images/Blue and Orange Game Time Instagram Post-4.jpg")
        aftPhoto5.image = UIImage(named: "images/afterflight menu images/Blue and Orange Game Time Instagram Post-5.jpg")
        plusButtons.append(contentsOf: [plusButton1,plusButton2,plusButton3,plusButton4,plusButton5])
        for i in plusButtons.indices {
            plusButtons[i].tag = (i+1) * 2
        }
        minusButtons.append(contentsOf: [minusButton1,minusButton2,minusButton3,minusButton4,minusButton5])
        for i in minusButtons.indices {
            minusButtons[i].tag = (i+1) * 2 + 1
        }
        countLabels.append(contentsOf: [count1,count2,count3,count4,count5])
        for i in countLabels.indices {
            do {
                let products = try self.database.prepare(self.productsTable.filter(self.productId == i + 1))
                for prod in products{
                    countLabels[i].text = String(prod[self.count])
                }
            } catch {
                print(error)
            }
        }
    }
    @IBAction func buttonClicked(_ sender: UIButton) {
        let senderInfo = sender.self.tag
        if(senderInfo % 2 == 0){
            var value = Int(countLabels[senderInfo/2 - 1].text!) ?? 0
            value += 1
            countLabels[senderInfo/2 - 1].text = "\(value)"
        } else {
            var value = Int(countLabels[(senderInfo-1)/2 - 1].text!) ?? 0
            if(value > 0){
                value -= 1
                countLabels[(senderInfo-1)/2 - 1].text = "\(value)"
            }
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
    
    func updateTable(){
        
        do {
            let products = try self.database.prepare(self.productsTable.filter(self.productType == "After Flight"))
           
            for product in products {
                
                let currentCount = Int(countLabels[product[self.productId] - 1].text!) ?? 0
                let updateProduct = self.productsTable.filter(self.productId == product[self.productId]).update(self.count <- currentCount)
                do {
                    try self.database.run(updateProduct)
                } catch {
                    print(error)
                }
                
            }
        } catch {
            print(error)
        }
    }
    @IBAction func addItemButtonClicked(_ sender: UIButton) {
        updateTable()
    }
}