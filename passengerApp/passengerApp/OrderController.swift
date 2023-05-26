//
//  OrderController.swift
//  passengerApp
//
//  Created by Doga Ege Inhanli on 15.04.2023.
//

import UIKit
import SQLite

class OrderController: UIViewController {
    
    var database: Connection!
    let productsTable = Table("Products")
    let productId = Expression<Int>("productId")
    let productName = Expression<String>("productName")
    let productType = Expression<String>("productType")
    let count = Expression<Int>("count")
    let price = Expression<Double>("price")
    

    @IBOutlet weak var menuImage3: UIImageView!
    @IBOutlet weak var menuImage6: UIImageView!
    @IBOutlet weak var menuImage7: UIImageView!
    @IBOutlet weak var foodMenuView: UIView!
    @IBOutlet weak var entertainmentMenuView: UIView!
    @IBOutlet weak var afterFlightServicesView: UIView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var proceedPaymentButton: UIButton!
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var totalLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        connectDatabase()
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height
        let screenWidth = screenSize.width
        let navigationItem = UINavigationItem(title: "Order")
        
        let back = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                   style: .plain,
                                   target: self,
                                   action: #selector(goBack))
        navigationItem.leftBarButtonItem = back

        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: screenHeight/25, width: view.frame.width, height: 44))
        navigationBar.barTintColor = self.view.backgroundColor
        navigationBar.setItems([navigationItem], animated: false)

        view.addSubview(navigationBar)
      
        menuImage3.image = UIImage(named: "images/add payment page images/menu2.jpeg")
        menuImage6.image = UIImage(named: "images/add payment page images/menu6.jpeg")
        menuImage7.image = UIImage(named: "images/add payment page images/menu7.jpeg")
        foodMenuView.frame.size.width = screenWidth * 0.9
        foodMenuView.center.y = navigationBar.frame.maxY + 1.25 * foodMenuView.bounds.size.height/2
        foodMenuView.layer.cornerRadius = 8.0
        foodMenuView.clipsToBounds = true
        
        entertainmentMenuView.frame.size.width = screenWidth * 0.9
        entertainmentMenuView.center.y = foodMenuView.frame.maxY + 1.25 * entertainmentMenuView.bounds.size.height/2
        entertainmentMenuView.layer.cornerRadius = 8.0
        entertainmentMenuView.clipsToBounds = true
        
        afterFlightServicesView.frame.size.width = screenWidth * 0.9
        afterFlightServicesView.center.y = entertainmentMenuView.frame.maxY + 1.25 * afterFlightServicesView.bounds.size.height/2
        afterFlightServicesView.layer.cornerRadius = 8.0
        afterFlightServicesView.clipsToBounds = true
        
        proceedPaymentButton.center.y = screenHeight * 0.95 - 1.5 * proceedPaymentButton.bounds.size.height
        totalView.center.y = proceedPaymentButton.center.y - 1.1 * totalView.frame.size.height
        totalView.layer.cornerRadius = 8.0
        totalView.clipsToBounds = true
        
        let scrollViewContainer: UIStackView = {
            let view = UIStackView()
            view.axis = .vertical
            view.spacing = 10
            view.backgroundColor = .white
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        scrollViewContainer.backgroundColor = entertainmentMenuView.backgroundColor
        scrollView.frame.size.width = screenWidth * 0.9
        scrollView.layer.cornerRadius = 8.0
        scrollView.clipsToBounds = true
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
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "mainViewController") {
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true, completion: nil)
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
    
    func updateBasket(container : UIStackView){
        do {
            let products = try self.database.prepare(self.productsTable.filter(self.count != 0))
            var labelPosY = 20
            var totalPrice = 0.0
            for product in products {
                let productStackView = UIStackView()
                productStackView.axis = .horizontal
                productStackView.alignment = .fill
                productStackView.distribution = .fill

                let productLabel = UILabel()
                productLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
                let productName = product[self.productName]
                let count = product[self.count]
                let productText = String(count) + "   x   " + productName
                productLabel.text = productText

                let priceLabel = UILabel()
                priceLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
                priceLabel.textAlignment = .right
                let price = product[self.price]
                let totalPriceForProd = price * Double(count)
                let priceText = String(totalPriceForProd) + " ₺ "
                priceLabel.text = priceText

                productStackView.addArrangedSubview(productLabel)
                productStackView.addArrangedSubview(priceLabel)
                container.addArrangedSubview(productStackView)

                totalPrice += totalPriceForProd
                labelPosY += 30
            }
            let roundedTotalPrice = totalPrice.rounded(toPlaces: 2)
            totalLabel.text = "Total Amount: " + String(roundedTotalPrice) + " ₺ "
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
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "QRCodePageController") as! QRCodePageController
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }
   
}
extension FloatingPoint {
    func rounded(toPlaces places: Int) -> Self {
        let divisor = Self(Int(pow(10.0, Double(places))))
        return (self * divisor).rounded() / divisor
    }
}
