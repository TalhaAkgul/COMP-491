//
//  SpendingDetailsController.swift
//  application
//
//  Created by Doga Ege Inhanli on 8.05.2023.
//

import UIKit
import SQLite
import MultipeerConnectivity

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
    
    let sessionManager = SessionManager.shared
    var mcSession: MCSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectDatabase2()
        connectDatabase3()
        mcSession = self.sessionManager.mcSession
        retrieveTransactionsFromConnectedDevices()
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
            print("Error occurred while accessing database: \(error)")
        }
        
        do {
            let filteredTransactions = transactionTable.filter(passengerId == currentId)
            for transaction in try database2.prepare(filteredTransactions) {
                let transactionAmount = transaction[amount]
                let transactionId = transaction[transactionId]
                let lineStackView = UIStackView()
                lineStackView.axis = .horizontal
                lineStackView.spacing = 8.0
                let spentLabel = UILabel(frame: CGRect(x: 20, y: 0, width: 200, height: 15))

                let formattedId = transactionId.replacingOccurrences(of: " +0000", with: "")

                let spentText = "   Date: " + formattedId + " Amount: " + String(transactionAmount) + "₺"
                
                spentLabel.text = spentText
                spentLabel.textColor = UIColor.black
                spentLabel.font = UIFont.systemFont(ofSize: 12.0)

                let button = UIButton(type: .system)
                button.frame = CGRect(x: 220, y: 0, width: 40, height: 10)
                button.setTitle("Refund", for: .normal)
                button.setTitleColor(.white, for: .normal)
                button.backgroundColor = UIColor.systemBlue
                button.widthAnchor.constraint(equalToConstant: 50).isActive = true
                button.heightAnchor.constraint(equalToConstant: 15).isActive = true
                button.addTarget(self, action: #selector(refundButtonTapped(_:)), for: .touchUpInside)
                
                lineStackView.addArrangedSubview(spentLabel)
                lineStackView.addArrangedSubview(button)
                container.addArrangedSubview(lineStackView)
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    @objc func refundButtonTapped(_ sender: UIButton) {
        guard let lineStackView = sender.superview as? UIStackView else {
            return
        }
        guard let spentLabel = lineStackView.arrangedSubviews.first as? UILabel else {
            return
        }
        
        let labelText = spentLabel.text ?? ""
        
        let components = labelText.components(separatedBy: " ")
        guard components.count >= 6 else {return}
        let date = components[4] + " " + components[5]
        
        let amountString = components[7].replacingOccurrences(of: "₺", with: "")
        guard let amountCancel = Double(amountString) else {return}
        let negativeAmount = -amountCancel
        var currentId = ""
        do {
            if let qrRow = try database3.pluck(qrTable) {
                currentId  = qrRow[pId]
                do {
                    let insert = transactionTable.insert(transactionId <- date, amount <- negativeAmount, passengerId <- currentId)
                    try database2.run(insert)
                    
                    print("New transaction inserted")
                } catch {
                    print("Error inserting transaction: \(error)")
                }
            }
        } catch {
            print("Error occurred while accessing database: \(error)")
        }
        
        sendTransactionsToConnectedDevices()
    }
    
    func sendTransactionsToConnectedDevices(){
        sessionManager.sendTransactions()
    }
    
    func retrieveTransactionsFromConnectedDevices(){
        sessionManager.sendSyncRequest()
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


