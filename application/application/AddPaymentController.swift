//
//  AddPaymentController.swift
//  application
//
//  Created by Doga Ege Inhanli on 3.04.2023.
//

import UIKit
import SQLite

class AddPaymentController: UIViewController {
    
    var database: Connection!
    let productsTable = Table("Products")
    let productId = Expression<Int>("productId")
    let productName = Expression<String>("productName")
    let productType = Expression<String>("productType")
    let count = Expression<Int>("count")
    let price = Expression<Double>("price")
    
    var database2: Connection!
    let transactionTable = Table("Transaction")
    let transactionId = Expression<String>("transactionId")
    let amount = Expression<Double>("amount")
    let passengerId = Expression<String>("passengerId")
    
    var database3: Connection!
    let qrTable = Table("QR")
    let pId = Expression<String>("pId")
    let prId = Expression<String>("prId")
    let prCount = Expression<String>("prCount")
    
    @IBOutlet weak var foodDrinkMenuView: UIView!
    var totalPrice: Double!
    
    @IBOutlet weak var menuImage5: UIImageView!
    @IBOutlet weak var menuImage6: UIImageView!
    @IBOutlet weak var menuImage7: UIImageView!
    @IBOutlet weak var foodMenuView: UIView!
    @IBOutlet weak var entertainmentMenuView: UIView!
    @IBOutlet weak var afterFlightServicesView: UIView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var foodDrinkButton: UIButton!
    @IBOutlet weak var entertainmentButton: UIButton!
    @IBOutlet weak var afterFlightButton: UIButton!
    @IBOutlet weak var proceedPaymentButton: UIButton!
    @IBOutlet weak var cancelPaymentButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        connectDatabase()
        connectDatabase2()
        connectDatabase3()
        
        menuImage5.image = UIImage(named: "images/add payment page images/menu2.jpeg")
        menuImage6.image = UIImage(named: "images/add payment page images/menu6.jpeg")
        menuImage7.image = UIImage(named: "images/add payment page images/menu7.jpeg")
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height
        let screenWidth  = screenSize.width
        
        foodDrinkMenuView.frame.size.width = screenWidth
        foodDrinkMenuView.center.x = self.view.center.x
        foodDrinkMenuView.center.y = navigationBar.frame.maxY + foodDrinkMenuView.bounds.size.height/2
        foodDrinkButton.center.x = self.view.center.x
        menuImage5.center.x = self.view.center.x
        
        entertainmentMenuView.frame.size.width = screenWidth
        entertainmentMenuView.center.x = self.view.center.x
        entertainmentMenuView.center.y = foodDrinkMenuView.frame.maxY + entertainmentMenuView.bounds.size.height/2
        entertainmentButton.center.x = self.view.center.x
        menuImage6.center.x = self.view.center.x
        
        afterFlightServicesView.frame.size.width = screenWidth
        afterFlightServicesView.center.x = self.view.center.x
        afterFlightServicesView.center.y = entertainmentMenuView.frame.maxY + afterFlightServicesView.bounds.size.height/2
        afterFlightButton.center.x = self.view.center.x
        menuImage7.center.x = self.view.center.x
        
        cancelPaymentButton.center.x = self.view.center.x
        cancelPaymentButton.center.y = screenHeight * 0.95
        
        proceedPaymentButton.center.x = self.view.center.x
        proceedPaymentButton.center.y = cancelPaymentButton.center.y - 1.5 * proceedPaymentButton.bounds.size.height
        
        totalView.center.x = self.view.center.x
        totalView.center.y = proceedPaymentButton.center.y - 1.1 * totalView.frame.size.height
        
        let scrollViewContainer: UIStackView = {
            let view = UIStackView()

            view.axis = .vertical
            view.spacing = 10
            view.backgroundColor = .white
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        updateBasket(container : scrollViewContainer)
        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        // this is important for scrolling
        scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        scrollView.center.x = self.view.center.x
        scrollView.center.y = afterFlightServicesView.frame.maxY + scrollView.frame.size.height/2 + 10
        
        scrollView.frame.size.height = totalView.frame.minY - scrollView.frame.minY - 20
        
        
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
    func connectDatabase2(){
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
            let fileUrl = documentDirectory.appendingPathComponent("Transaction").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database2 = database
        } catch {
            print(error)
        }
    }
    func updateBasket(container : UIStackView){
        
        do {
            let products = try self.database.prepare(self.productsTable.filter(self.count != 0))
            var labelPosY = 20
            totalPrice = 0.0
            for product in products {
                let productLabel = UILabel()
                productLabel.textColor = UIColor.black
                productLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
                let productName = product[self.productName]
                let count = product[self.count]
                let productText = String(count) + "   x   " + productName
                let price = product[self.price]
                let totalPriceForProd = price * Double(count)
                let priceText = String(totalPriceForProd) + " ₺ "
                let text = productText + ": " + priceText
                productLabel.text = text
                container.addArrangedSubview(productLabel)
                totalPrice = totalPrice + totalPriceForProd
                labelPosY = labelPosY + 30
            }
            totalLabel.text = "Total Amount: " + String(totalPrice) + " ₺ "
            totalLabel.textAlignment = .right
        } catch {
            print(error)
        }
    }
    
    @IBAction func cancelPaymentClicked(_ sender: UIButton) {
        let productsAtBasket = self.productsTable.filter(self.count != 0)
        let cancelBasket = productsAtBasket.update(self.count <- 0)
        do {
            try self.database.run(cancelBasket)
        } catch {
            print(error)
        }
    }
    
    
    @IBAction func proceedPaymentClicked(_ sender: UIButton) {
        /*
         
         
         
        The main database will be updated according to the payment amount and the passenger
         
         
         */
        guard let path = Bundle.main.path(forResource: "serverData", ofType: "json") else {
            fatalError("Couldn't find file 'serverData.json' in app bundle.")
        }
        
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            print(data)
            do {
                let decoder = JSONDecoder()
                let serverInfos = try decoder.decode([ServerData].self, from: data)
                var currentId = ""
                var totalSpendings = 0.0
                if let qrRow = try database3.pluck(qrTable) {
                    currentId  = qrRow[pId]
                }
                do {
                    let filteredRows = try database2.prepare(transactionTable.filter(passengerId == currentId))
                    for row in filteredRows {
                        let transactionAmount = Double(row[amount])
                        totalSpendings += transactionAmount
                        print("Transaction Amount: \(transactionAmount)")
                    }
                } catch {
                    print("Error selecting transactions: \(error)")
                }

                for serverInfo in serverInfos {
                    if serverInfo.passengerId == currentId {
                        let serverAmount = serverInfo.amount
                        let amountValue = Double(serverAmount) ?? 0.0
                        let remainingAmount = amountValue - totalSpendings
                        if totalPrice > remainingAmount {
                            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
                            let blurEffectView = UIVisualEffectView(effect: blurEffect)
                            blurEffectView.frame = view.bounds
                            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                            view.addSubview(blurEffectView)
                            
                            let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopUpAfterProceedPayment") as! PopupAfterProceedPaymentController
                            self.addChild(popOverVC)
                            popOverVC.view.frame = self.view.frame
                            self.view.addSubview(popOverVC.view)
                            popOverVC.didMove(toParent: self)
                        } else {
                            do {
                                let time = ("\(Date())")
                                // Insert a new row into the table
                                //print(totalPrice)
                                //print(time)
                                //print(currentId)
                                let insert = transactionTable.insert(transactionId <- time, amount <- totalPrice, passengerId <- currentId)
                                
                                // Execute the insert statement
                                try database2.run(insert)
                                
                                print("New transaction inserted")
                            } catch {
                                print("Error inserting transaction: \(error)")
                            }
                            
                            let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PaymentSuccessfulController") as! PaymentSuccessfulController
                            self.addChild(popOverVC)
                            popOverVC.view.frame = self.view.frame
                            self.view.addSubview(popOverVC.view)
                            popOverVC.didMove(toParent: self)
                            
                        }
                        
                    }
                        }
                    } catch {
                      print(error)
                    }        } catch {
            fatalError("Couldn't load contents of file at path '\(url)': \(error)")
        }
        
        
        
        /*
        let productsAtBasket = self.productsTable.filter(self.count != 0)
        let completeBasket = productsAtBasket.update(self.count <- 0)
        do {
            try self.database.run(completeBasket)
        } catch {
            print(error)
        }
        */
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
}
