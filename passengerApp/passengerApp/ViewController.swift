//
//  ViewController.swift
//  passengerApp
//
//  Created by Doga Ege Inhanli on 15.04.2023.
//

import UIKit
import SQLite

class ViewController: UIViewController {

    var database: Connection!
    let productsTable = Table("Products")
    let productId = Expression<Int>("productId")
    let productName = Expression<String>("productName")
    let productType = Expression<String>("productType")
    let count = Expression<Int>("count")
    let price = Expression<Double>("price")
    
    let customerTable = Table("Passenger")
    let passId = Expression<String>("passId")
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var generateQRWithoutOrderButton: UIButton!
    @IBOutlet weak var generateQRWithOrderButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Local database for the products
        initializeDatabase()
        
        // Do any additional setup after loading the view.
        self.view.addBackground()
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height
        
        //Welcome Label
        welcomeLabel.center.x = self.view.center.x
        welcomeLabel.center.y = self.view.center.y + screenHeight/20
        welcomeLabel.textAlignment = .center
        
        //Identification Label
        
        instructionLabel.center.x = self.view.center.x
        instructionLabel.center.y = welcomeLabel.center.y + welcomeLabel.bounds.size.height
        instructionLabel.textAlignment = .center
        
        
        idTextField.center.x = self.view.center.x
        idTextField.center.y = instructionLabel.center.y +
        2.5*instructionLabel.bounds.size.height
       
        
        generateQRWithoutOrderButton.center.x = self.view.center.x
        generateQRWithoutOrderButton.center.y = idTextField.center.y + 1.25*generateQRWithoutOrderButton.bounds.size.height
        
        generateQRWithOrderButton.center.x = self.view.center.x
        generateQRWithOrderButton.center.y = generateQRWithoutOrderButton.center.y + 1.25*generateQRWithOrderButton.bounds.size.height
        
    }
    
    func initializeDatabase(){
        
        
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
            let fileUrl = documentDirectory.appendingPathComponent("Products").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch {
            print(error)
        }
        
        do {
            let drop = customerTable.drop(ifExists: true)
            try database.run(drop)
        } catch {
            print(error)
        }
        /*
        let createTable = self.productsTable.create { (table) in
            table.column(self.productId, primaryKey: true)
            table.column(self.productName)
            table.column(self.productType)
            table.column(self.count)
            table.column(self.price)
        }
        
        do {
            try self.database.run(createTable)
            print("Created Table")
        } catch {
            print(error)
        }
         */
        let createTable2 = self.customerTable.create { (table) in
            table.column(self.passId, primaryKey: true)
        }
          
        do {
            try self.database.run(createTable2)
        } catch {
            print(error)
        }
        
        let insertUser = self.productsTable.insertMany(or: OnConflict.replace,
                                                       [[self.productId <- 1, self.productName <- "Suitcase Help", self.productType <- "After Flight", self.count <- 0, self.price <- 200.0],
                                                        [self.productId <- 2, self.productName <- "Rent A Car", self.productType <- "After Flight", self.count <- 0, self.price <- 570.0],
                                                        [self.productId <- 3, self.productName <- "Shuttle Service", self.productType <- "After Flight", self.count <- 0, self.price <- 55.0],
                                                        [self.productId <- 4, self.productName <- "Guided Tours", self.productType <- "After Flight", self.count <- 0, self.price <- 650.0],
                                                        [self.productId <- 5, self.productName <- "Airport Hotel", self.productType <- "After Flight", self.count <- 0, self.price <- 990.0],
                                                        [self.productId <- 6, self.productName <- "Daisies", self.productType <- "Entertainment", self.count <- 0, self.price <- 14.0],
                                                        [self.productId <- 7, self.productName <- "Legacy", self.productType <- "Entertainment", self.count <- 0, self.price <- 12.5],
                                                        [self.productId <- 8, self.productName <- "Never Again", self.productType <- "Entertainment", self.count <- 0, self.price <- 13.9],
                                                        [self.productId <- 9, self.productName <- "Pixels", self.productType <- "Entertainment", self.count <- 0, self.price <- 16.7],
                                                        [self.productId <- 10, self.productName <- "Anchor", self.productType <- "Entertainment", self.count <- 0, self.price <- 20.0],
                                                        [self.productId <- 11, self.productName <- "Flying High", self.productType <- "Entertainment", self.count <- 0, self.price <- 8.0],
                                                        [self.productId <- 12, self.productName <- "Mind", self.productType <- "Entertainment", self.count <- 0, self.price <- 9.2],
                                                        [self.productId <- 13, self.productName <- "Old Times", self.productType <- "Entertainment", self.count <- 0, self.price <- 7.8],
                                                        [self.productId <- 14, self.productName <- "New World", self.productType <- "Entertainment", self.count <- 0, self.price <- 12.3],
                                                        [self.productId <- 15, self.productName <- "Our Story", self.productType <- "Entertainment", self.count <- 0, self.price <- 8.7],
                                                        [self.productId <- 16, self.productName <- "Maze", self.productType <- "Entertainment", self.count <- 0, self.price <- 13.4],
                                                        [self.productId <- 17, self.productName <- "Race", self.productType <- "Entertainment", self.count <- 0, self.price <- 14.3],
                                                        [self.productId <- 18, self.productName <- "Trivia", self.productType <- "Entertainment", self.count <- 0, self.price <- 11.1],
                                                        [self.productId <- 19, self.productName <- "War", self.productType <- "Entertainment", self.count <- 0, self.price <- 12.6],
                                                        [self.productId <- 20, self.productName <- "Inflight", self.productType <- "Entertainment", self.count <- 0, self.price <- 17.3],
                                                        [self.productId <- 21, self.productName <- "Mosaic", self.productType <- "Entertainment", self.count <- 0, self.price <- 11.6],
                                                        [self.productId <- 22, self.productName <- "Avocado Bowl", self.productType <- "Food Drink", self.count <- 0, self.price <- 60.0],
                                                        [self.productId <- 23, self.productName <- "Bacon Wrap", self.productType <- "Food Drink", self.count <- 0, self.price <- 85.0],
                                                        [self.productId <- 24, self.productName <- "Chicken Wrap", self.productType <- "Food Drink", self.count <- 0, self.price <- 70.0],
                                                        [self.productId <- 25, self.productName <- "Croissant Sandwich", self.productType <- "Food Drink", self.count <- 0, self.price <- 40.0],
                                                        [self.productId <- 26, self.productName <- "English Breakfast", self.productType <- "Food Drink", self.count <- 0, self.price <- 42.0],
                                                        [self.productId <- 27, self.productName <- "Fish&Chips", self.productType <- "Food Drink", self.count <- 0, self.price <- 55.5],
                                                        [self.productId <- 28, self.productName <- "Green Salad", self.productType <- "Food Drink", self.count <- 0, self.price <- 43.9],
                                                        [self.productId <- 29, self.productName <- "Ham Cheese Sandwich", self.productType <- "Food Drink", self.count <- 0, self.price <- 46.7],
                                                        [self.productId <- 30, self.productName <- "Mediterranean Salad", self.productType <- "Food Drink", self.count <- 0, self.price <- 40.0],
                                                        [self.productId <- 31, self.productName <- "Pancakes", self.productType <- "Food Drink", self.count <- 0, self.price <- 38.0],
                                                        [self.productId <- 32, self.productName <- "Schnitzel", self.productType <- "Food Drink", self.count <- 0, self.price <- 67.2],
                                                        [self.productId <- 33, self.productName <- "Simple Breakfast", self.productType <- "Food Drink", self.count <- 0, self.price <- 39.8],
                                                        [self.productId <- 34, self.productName <- "Steak", self.productType <- "Food Drink", self.count <- 0, self.price <- 104.3],
                                                        [self.productId <- 35, self.productName <- "Vegetarian Wrap", self.productType <- "Food Drink", self.count <- 0, self.price <- 60.7],
                                                        [self.productId <- 36, self.productName <- "Apple", self.productType <- "Food Drink", self.count <- 0, self.price <- 10.4],
                                                        [self.productId <- 37, self.productName <- "Banana", self.productType <- "Food Drink", self.count <- 0, self.price <- 10.4],
                                                        [self.productId <- 38, self.productName <- "Bluberry Muffin", self.productType <- "Food Drink", self.count <- 0, self.price <- 28.1],
                                                        [self.productId <- 39, self.productName <- "Chips", self.productType <- "Food Drink", self.count <- 0, self.price <- 15.6],
                                                        [self.productId <- 40, self.productName <- "Chocolate Bar", self.productType <- "Food Drink", self.count <- 0, self.price <- 9.3],
                                                        [self.productId <- 41, self.productName <- "Chocolate Donut", self.productType <- "Food Drink", self.count <- 0, self.price <- 20.6],
                                                        [self.productId <- 42, self.productName <- "Icecream", self.productType <- "Food Drink", self.count <- 0, self.price <- 12.0],
                                                        [self.productId <- 43, self.productName <- "Protein Bar", self.productType <- "Food Drink", self.count <- 0, self.price <- 9.0],
                                                        [self.productId <- 44, self.productName <- "Ruby Chocolate Donut", self.productType <- "Food Drink", self.count <- 0, self.price <- 30.0],
                                                        [self.productId <- 45, self.productName <- "Americano", self.productType <- "Food Drink", self.count <- 0, self.price <- 20.0],
                                                        [self.productId <- 46, self.productName <- "Beer", self.productType <- "Food Drink", self.count <- 0, self.price <- 50.0],
                                                        [self.productId <- 47, self.productName <- "Cappucino", self.productType <- "Food Drink", self.count <- 0, self.price <- 30.0],
                                                        [self.productId <- 48, self.productName <- "Coke", self.productType <- "Food Drink", self.count <- 0, self.price <- 30.9],
                                                        [self.productId <- 49, self.productName <- "Gin Tonic", self.productType <- "Food Drink", self.count <- 0, self.price <- 60.7],
                                                        [self.productId <- 50, self.productName <- "Latte", self.productType <- "Food Drink", self.count <- 0, self.price <- 25.0],
                                                        [self.productId <- 51, self.productName <- "Mimosa", self.productType <- "Food Drink", self.count <- 0, self.price <- 30.0],
                                                        [self.productId <- 52, self.productName <- "Multi Fruit Juice", self.productType <- "Food Drink", self.count <- 0, self.price <- 15.2],
                                                        [self.productId <- 53, self.productName <- "Orange Juice", self.productType <- "Food Drink", self.count <- 0, self.price <- 15.3],
                                                        [self.productId <- 54, self.productName <- "Red Wine", self.productType <- "Food Drink", self.count <- 0, self.price <- 8.7],
                                                        [self.productId <- 55, self.productName <- "Rose Wine", self.productType <- "Food Drink", self.count <- 0, self.price <- 60.4],
                                                        [self.productId <- 56, self.productName <- "Tea", self.productType <- "Food Drink", self.count <- 0, self.price <- 14.3],
                                                        [self.productId <- 57, self.productName <- "White Wine", self.productType <- "Food Drink", self.count <- 0, self.price <- 60.1]])
        do {
            try self.database.run(insertUser)
        } catch {
            print(error)
        }
    }
    @IBAction func generateQRCodeWithoutOrderButtonClicked(_ sender: UIButton) {
        let insertPass = self.customerTable.insert(self.passId <- idTextField.text!)
                            
        do {
            try self.database.run(insertPass)
        } catch {
            print(error)
        }
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
    
    @IBAction func generateQRCodeWithOrderButtonClicked(_ sender: UIButton) {
        let insertPass = self.customerTable.insert(self.passId <- idTextField.text!)
                            
        do {
            try self.database.run(insertPass)
        } catch {
            print(error)
        }
    }
    
}



