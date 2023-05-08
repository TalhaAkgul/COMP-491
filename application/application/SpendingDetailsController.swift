//
//  SpendingDetailsController.swift
//  application
//
//  Created by Doga Ege Inhanli on 8.05.2023.
//

import UIKit
import SQLite

class SpendingDetailsController: UIViewController {
    
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
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var okButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectDatabase2()
        connectDatabase3()
        showAnimate()
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height
        let screenWidth  = screenSize.width
        let scrollViewContainer: UIStackView = {
            let view = UIStackView()

            view.axis = .vertical
            view.spacing = 10
            view.backgroundColor = .white
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        // this is important for scrolling
        scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        scrollView.frame.size.width = screenWidth * 0.85
        scrollView.frame.size.height = screenHeight * 0.2
        scrollView.center.y = self.view.center.y
        scrollView.center.x = self.view.center.x
        
        okButton.center.x = self.view.center.x
        okButton.center.y = scrollView.frame.maxY + okButton.bounds.size.height + screenHeight/25
        fillScrollWithSpendings(container : scrollViewContainer)
    }
    
    func fillScrollWithSpendings(container : UIStackView){
        
        var currentId = ""
        do {
            if let qrRow = try database3.pluck(qrTable) {
                currentId  = qrRow[pId]
            }
        } catch {
            // Handle the error here
            print("Error occurred while accessing database: \(error)")
        }
        
        do {
            // Filter transactions by passengerId
            let filteredTransactions = transactionTable.filter(passengerId == currentId)
            
            // Iterate through the filtered transactions and print the amounts
            for transaction in try database2.prepare(filteredTransactions) {
                let transactionAmount = transaction[amount]
                let transactionId = transaction[transactionId]
                //print("Amount: \(transactionAmount)")
                let spentLabel = UILabel()
                
                let formattedId = transactionId.replacingOccurrences(of: " +0000", with: "")

                let spentText = "Date: " + formattedId + " Amount: " + String(transactionAmount) + "₺"
                
                spentLabel.text = spentText
                spentLabel.textColor = UIColor.black
                spentLabel.font = UIFont(name: "Montserrat-Light", size: 8.0)
                container.addArrangedSubview(spentLabel)
            }
        } catch {
            // Handle any errors that occur
            print("Error: \(error)")
        }


            
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
    
}


