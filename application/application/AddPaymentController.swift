//
//  AddPaymentController.swift
//  application
//
//  Created by Doga Ege Inhanli on 3.04.2023.
//

import UIKit
import SQLite
import MultipeerConnectivity

class AddPaymentController: UIViewController {
    
    
    @IBOutlet weak var foodDrinkMenuView: UIView!
    var totalPrice: Double!
    
    @IBOutlet weak var menuImage5: UIImageView!
    @IBOutlet weak var menuImage6: UIImageView!
    @IBOutlet weak var menuImage7: UIImageView!
    @IBOutlet weak var foodMenuView: UIView!
    @IBOutlet weak var entertainmentMenuView: UIView!
    @IBOutlet weak var afterFlightServicesView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var foodDrinkButton: UIButton!
    @IBOutlet weak var entertainmentButton: UIButton!
    @IBOutlet weak var afterFlightButton: UIButton!
    @IBOutlet weak var proceedPaymentButton: UIButton!
    @IBOutlet weak var cancelPaymentButton: UIButton!
    
    let sessionManager = SessionManager.shared
    var mcSession: MCSession!
    
    let databaseController = DatabaseController.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseController.connectMenuDatabase()
        databaseController.connectTransactionDatabase()
        databaseController.connectQRDatabase()
        setItems()
        mcSession = self.sessionManager.mcSession
    }
    
    func setItems(){
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height
        let screenWidth  = screenSize.width
        
        let navigationItem = UINavigationItem(title: "Add Payment")
        
        let back = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                   style: .plain,
                                   target: self,
                                   action: #selector(goBack))
        navigationItem.leftBarButtonItem = back

        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: screenHeight/25, width: view.frame.width, height: 44))
        navigationBar.barTintColor = UIColor(white: 0.95, alpha: 1.0)
        navigationBar.setItems([navigationItem], animated: false)

        view.addSubview(navigationBar)
        
        menuImage5.image = UIImage(named: "images/add payment page images/menu2.jpeg")
        menuImage6.image = UIImage(named: "images/add payment page images/menu6.jpeg")
        menuImage7.image = UIImage(named: "images/add payment page images/menu7.jpeg")
        
        
        foodDrinkMenuView.frame.size.width = screenWidth * 0.9
        foodDrinkMenuView.center.y = navigationBar.frame.maxY + 1.25 * foodDrinkMenuView.bounds.size.height/2
        foodDrinkMenuView.center.x = self.view.center.x
        
        entertainmentMenuView.frame.size.width = screenWidth * 0.9
        entertainmentMenuView.center.y = foodDrinkMenuView.frame.maxY + 1.25 * entertainmentMenuView.bounds.size.height/2
        entertainmentMenuView.center.x = self.view.center.x
        
        afterFlightServicesView.frame.size.width = screenWidth * 0.9
        afterFlightServicesView.center.y = entertainmentMenuView.frame.maxY + 1.25 * afterFlightServicesView.bounds.size.height/2
        afterFlightServicesView.center.x = self.view.center.x
        
        cancelPaymentButton.center.y = screenHeight * 0.95
        proceedPaymentButton.center.y = cancelPaymentButton.center.y - 1.5 * proceedPaymentButton.bounds.size.height
        totalView.center.y = proceedPaymentButton.center.y - 1.1 * totalView.frame.size.height
        
        let scrollViewContainer: UIStackView = {
            let view = UIStackView()
            view.axis = .vertical
            view.spacing = 10
            view.backgroundColor = .white
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        scrollView.frame.size.width = screenWidth * 0.9
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
    
    @objc func goBack() {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "PersonalDetailsController") {
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true, completion: nil)
        }
    }
    
    
    func updateBasket(container : UIStackView){
        do {
            let products = try databaseController.database.prepare(databaseController.productsTable.filter(databaseController.count != 0))
            var labelPosY = 20
            totalPrice = 0.0
            for product in products {
                let productLabel = UILabel()
                productLabel.textColor = UIColor.black
                productLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
                let productName = product[databaseController.productName]
                let count = product[databaseController.count]
                let productText = String(count) + "   x   " + productName
                let price = product[databaseController.price]
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
        let productsAtBasket = databaseController.productsTable.filter(databaseController.count != 0)
        let cancelBasket = productsAtBasket.update(databaseController.count <- 0)
        do {
            try databaseController.database.run(cancelBasket)
        } catch {
            print(error)
        }
    }
    
    
    @IBAction func proceedPaymentClicked(_ sender: UIButton) {
        retrieveTransactionsFromConnectedDevices()
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Couldn't access the document directory.")
        }

        let url = documentsDirectory.appendingPathComponent("serverData.json")
        do {
            let data = try Data(contentsOf: url)
            print(data)
            do {
                let decoder = JSONDecoder()
                let serverInfos = try decoder.decode([ServerData].self, from: data)
                var currentId = ""
                var totalSpendings = 0.0
                if let qrRow = try databaseController.database3.pluck(databaseController.qrTable) {
                    currentId  = qrRow[databaseController.pId]
                }
                do {
                    let filteredRows = try databaseController.database2.prepare(databaseController.transactionTable.filter(databaseController.passengerId == currentId))
                    for row in filteredRows {
                        let transactionAmount = Double(row[databaseController.amount])
                        totalSpendings += transactionAmount
                        print("Transaction Amount: \(transactionAmount)")
                    }
                } catch {
                    print("Error selecting transactions: \(error)")
                }
                for serverInfo in serverInfos {
                    if serverInfo.passengerPID == currentId {
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
                                let insert = databaseController.transactionTable.insert(databaseController.transactionId <- time, databaseController.amount <- totalPrice, databaseController.passengerId <- currentId)
                                try databaseController.database2.run(insert)
                            } catch {
                                print("Error inserting transaction: \(error)")
                            }
                            
                            sendTransactionsToConnectedDevices()
                            
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
    }
    
    func sendTransactionsToConnectedDevices(){
        sessionManager.sendTransactions()
    }
    
    func retrieveTransactionsFromConnectedDevices(){
        sessionManager.sendSyncRequest()
    }
}
