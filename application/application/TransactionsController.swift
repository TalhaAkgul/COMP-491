//
//  TransactionsController.swift
//  application
//
//  Created by Doga Ege Inhanli on 13.05.2023.
//
import UIKit
import SQLite

class TransactionsController: UIViewController {
    
    var database2: Connection!
    let transactionTable = Table("Transaction")
    let transactionId = Expression<String>("transactionId")
    let amount = Expression<Double>("amount")
    let passengerId = Expression<String>("passengerId")
    
    @IBOutlet weak var transactionText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        connectDatabase2()
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height
        let navigationItem = UINavigationItem(title: "Transactions")
        
        let back = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                   style: .plain,
                                   target: self,
                                   action: #selector(goBack))
        navigationItem.leftBarButtonItem = back

        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: screenHeight/25, width: view.frame.width, height: 44))
        navigationBar.barTintColor = UIColor(white: 0.95, alpha: 1.0)
        navigationBar.setItems([navigationItem], animated: false)

        view.addSubview(navigationBar)
        var transactionStr = ""
        do {
            let selectQuery = self.transactionTable.select(self.transactionId, self.amount, self.passengerId)
            let rows = try self.database2.prepare(selectQuery)
            for row in rows {
                transactionStr += """
                    transactionId: \(row[self.transactionId]), \
                    amount: \(row[self.amount]), \
                    passengerId: \(row[self.passengerId])
                """ + "\n"
            }
        } catch {
            print("Error selecting transactions from Transaction table: \(error)")
        }
        transactionText.text = transactionStr
    }
    @objc func goBack() {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "AdminController") {
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true, completion: nil)
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
