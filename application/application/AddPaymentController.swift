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
    
    var database3: Connection!
    let qrTable = Table("QR")
    let pId = Expression<String>("pId")
    let prId = Expression<String>("prId")
    let prCount = Expression<String>("prCount")
    
    var totalPrice: Double!
    
    @IBOutlet weak var menuImage1: UIImageView!
    @IBOutlet weak var menuImage2: UIImageView!
    @IBOutlet weak var menuImage3: UIImageView!
    @IBOutlet weak var menuImage4: UIImageView!
    @IBOutlet weak var menuImage5: UIImageView!
    @IBOutlet weak var menuImage6: UIImageView!
    @IBOutlet weak var menuImage7: UIImageView!
    @IBOutlet weak var foodMenuView: UIView!
    @IBOutlet weak var entertainmentMenuView: UIView!
    @IBOutlet weak var afterFlightServicesView: UIView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var basketImage: UIImageView!
    @IBOutlet weak var proceedPaymentButton: UIButton!
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var totalLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        connectDatabase()
        connectDatabase3()
        menuImage1.image = UIImage(named: "images/add payment page images/menu1.jpeg")
        menuImage2.image = UIImage(named: "images/add payment page images/menu2.jpeg")
        menuImage3.image = UIImage(named: "images/add payment page images/menu3.jpeg")
        menuImage4.image = UIImage(named: "images/add payment page images/menu4.jpeg")
        menuImage5.image = UIImage(named: "images/add payment page images/menu5.jpeg")
        menuImage6.image = UIImage(named: "images/add payment page images/menu6.jpeg")
        menuImage7.image = UIImage(named: "images/add payment page images/menu7.jpeg")
        
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
        /*
        scrollViewContainer2.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollViewContainer2.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollViewContainer2.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true*/
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
    
    func updateBasket(container : UIStackView){
        
        do {
            let products = try self.database.prepare(self.productsTable.filter(self.count != 0))
            var labelPosY = 20
            totalPrice = 0.0
            for product in products {
                let productLabel = UILabel()
                //productLabel.center = CGPoint(x: 160, y: 285)
                //productLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                productLabel.textColor = UIColor.black
                productLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
                let productName = product[self.productName]
                let count = product[self.count]
                let productText = String(count) + "   x   " + productName
                //productLabel.text = productText
                //let priceLabel = UILabel()
                //priceLabel.center = CGPoint(x: 160, y: 285)
                //priceLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                //priceLabel.textColor = UIColor.black
                let price = product[self.price]
                let totalPriceForProd = price * Double(count)
                let priceText = String(totalPriceForProd) + " ₺ "
                //priceLabel.text = priceText
                //priceLabel.textAlignment = .right
                let text = productText + ": " + priceText
                productLabel.text = text
                container.addArrangedSubview(productLabel)
                //container.addArrangedSubview(priceLabel)
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
                if let qrRow = try database3.pluck(qrTable) {
                    // Retrieve the value of pId column from the row and assign it to idLabel's text
                    currentId  = qrRow[pId]
                }
                for serverInfo in serverInfos {
                    if serverInfo.passengerId == currentId {
                        let amount = serverInfo.amount
                        let amountValue = Double(amount) ?? 0.0
                        if totalPrice > amountValue {
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
                            let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PaymentSuccessfulController") as! PaymentSuccessfulController
                            self.addChild(popOverVC)
                            popOverVC.view.frame = self.view.frame
                            self.view.addSubview(popOverVC.view)
                            popOverVC.didMove(toParent: self)                        }
                        
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
