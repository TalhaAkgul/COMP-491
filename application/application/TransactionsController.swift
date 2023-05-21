//
//  TransactionsController.swift
//  application
//
//  Created by Doga Ege Inhanli on 13.05.2023.
//
import UIKit
import SQLite

class TransactionsController: UIViewController {
    
    @IBOutlet weak var transactionText: UITextView!
    
    let databaseController = DatabaseController.instance

    override func viewDidLoad() {
        super.viewDidLoad()
        databaseController.connectTransactionDatabase()
        
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
            let selectQuery = databaseController.transactionTable.select(databaseController.transactionId, databaseController.amount, databaseController.passengerId)
            let rows = try databaseController.database2.prepare(selectQuery)
            for row in rows {
                transactionStr += """
                    transactionId: \(row[databaseController.transactionId]), \
                    amount: \(row[databaseController.amount]), \
                    passengerId: \(row[databaseController.passengerId])
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
}
