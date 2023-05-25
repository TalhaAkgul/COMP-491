//
//  TransactionsController.swift
//  application
//
//  Created by Doga Ege Inhanli on 13.05.2023.
//
import UIKit
import SQLite

class TransactionsController: UIViewController {
    

    @IBOutlet weak var scrollView: UIScrollView!
    
    let databaseController = DatabaseController.instance

    override func viewDidLoad() {
        super.viewDidLoad()
        databaseController.connectTransactionDatabase()
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height
        let screenWidth = screenSize.width
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
        
        scrollView.frame.size.height = screenHeight * 0.7
        scrollView.frame.size.width = screenWidth * 0.95
        scrollView.center.x = self.view.center.x
        scrollView.center.y = navigationBar.bounds.maxY + screenHeight/30 + scrollView.frame.height/2
        let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.spacing = 8
            stackView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(stackView)

        NSLayoutConstraint.activate([
                stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
                stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
                stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
                stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
            ])
        var transactionCount = 0
            do {
                let selectQuery = databaseController.transactionTable.select(databaseController.transactionId, databaseController.amount, databaseController.passengerId)
                let rows = try databaseController.database2.prepare(selectQuery)
                for row in rows {
                    let transactionStackView = UIStackView()
                    transactionStackView.axis = .vertical
                    transactionStackView.spacing = 4
                    transactionStackView.backgroundColor = .white
                    
                    let transactionIdLabel = UILabel()
                    transactionIdLabel.font = UIFont.systemFont(ofSize: 14)
                    transactionIdLabel.text = "Data and Time: \(row[databaseController.transactionId])"
                    let amountLabel = UILabel()
                    amountLabel.font = UIFont.systemFont(ofSize: 14)
                    amountLabel.text = "Amount: \(row[databaseController.amount])"
                    if(row[databaseController.amount] < 0){
                        amountLabel.text! += " (Payment Refunded)"
                    }
                    let passengerIdLabel = UILabel()
                    passengerIdLabel.font = UIFont.systemFont(ofSize: 14)
                    passengerIdLabel.text = "Passenger ID: \(row[databaseController.passengerId])"

                    [transactionIdLabel, amountLabel, passengerIdLabel].forEach { label in
                            transactionStackView.addArrangedSubview(label)
                    }

                    stackView.addArrangedSubview(transactionStackView)
                    transactionCount += 1
                }
            } catch {
                print("Error selecting transactions from Transaction table: \(error)")
            }
        let countView = UIStackView()
        countView.axis = .vertical
        countView.spacing = 8
        countView.translatesAutoresizingMaskIntoConstraints = false
        countView.backgroundColor = .white
        let countLabel = UILabel()
        countLabel.font = UIFont.systemFont(ofSize: 14)
        countLabel.text = "Number of Transactions: " + String(transactionCount)
        countLabel.textAlignment = .center
        countView.addArrangedSubview(countLabel)
        
        self.view.addSubview(countView)
        NSLayoutConstraint.activate([
            countView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 5),
            countView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            countView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
                countView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            countView.heightAnchor.constraint(equalToConstant: screenHeight / 20)

        ])
    }
    
    @objc func goBack() {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "AdminController") {
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true, completion: nil)
        }
    }
}
