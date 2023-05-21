//
//  AfterFlightServiceController.swift
//  application
//
//  Created by Doga Ege Inhanli on 3.04.2023.
//

import UIKit
import SQLite

class AfterFlightServicesController: UIViewController {
    
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
    
    @IBOutlet weak var price1: UILabel!
    @IBOutlet weak var price2: UILabel!
    @IBOutlet weak var price3: UILabel!
    @IBOutlet weak var price4: UILabel!
    @IBOutlet weak var price5: UILabel!
    
    var priceLabels = [UILabel]()
    var countLabels = [UILabel]()
    var plusButtons = [UIButton]()
    var minusButtons = [UIButton]()
    
    let databaseController = DatabaseController.instance

    override func viewDidLoad() {
        super.viewDidLoad()
        databaseController.connectMenuDatabase()
        setItems()
    }
    
    func setItems(){
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height
        
        let navigationItem = UINavigationItem(title: "After Flight Services")
        
        let back = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                   style: .plain,
                                   target: self,
                                   action: #selector(goBack))
        navigationItem.leftBarButtonItem = back

        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: screenHeight/25, width: view.frame.width, height: 44))
        navigationBar.barTintColor = UIColor(white: 0.95, alpha: 1.0)
        navigationBar.setItems([navigationItem], animated: false)

        view.addSubview(navigationBar)
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
        priceLabels.append(contentsOf: [price1,price2,price3,price4,price5])
        for i in countLabels.indices {
            do {
                let products = try databaseController.database.prepare(databaseController.productsTable.filter(databaseController.productId == i + 1))
                for prod in products{
                    countLabels[i].text = String(prod[databaseController.count])
                    priceLabels[i].text = String(prod[databaseController.price]) + " ₺"
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
    
    @objc func goBack() {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "AddPayment") {
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true, completion: nil)
        }
    }
    
    func updateTable(){
        do {
            let products = try databaseController.database.prepare(databaseController.productsTable.filter(databaseController.productType == "After Flight"))
            for product in products {
                let currentCount = Int(countLabels[product[databaseController.productId] - 1].text!) ?? 0
                let updateProduct = databaseController.productsTable.filter(databaseController.productId == product[databaseController.productId]).update(databaseController.count <- currentCount)
                do {
                    try databaseController.database.run(updateProduct)
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
