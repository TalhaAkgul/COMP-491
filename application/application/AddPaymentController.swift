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
        //self.view.backgroundColor = .red
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
        /*
        let scrollViewContainer2: UIStackView = {
            let view = UIStackView()

            view.axis = .vertical
            view.spacing = 10
            view.backgroundColor = .red
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        */
        
        updateBasket(container : scrollViewContainer)
        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        //scrollView.addSubview(scrollViewContainer2)
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
            //let labelPosX = 20
            var labelPosY = 20
            var totalPrice = 0.0
            for product in products {
                //print(product[self.productName])
                
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
        let productsAtBasket = self.productsTable.filter(self.count != 0)
        let completeBasket = productsAtBasket.update(self.count <- 0)
        do {
            try self.database.run(completeBasket)
        } catch {
            print(error)
        }
    }
}
