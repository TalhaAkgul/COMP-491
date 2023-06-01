//
//  TransactionsController.swift
//  application
//
//  Created by Doga Ege Inhanli on 25.05.2023.
//
import UIKit
import SQLite

class CloseController: UIViewController, URLSessionDelegate {
    

    @IBOutlet weak var scrollView: UIScrollView!
    
    let databaseController = DatabaseController.instance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
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
            countView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 16),
            countView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            countView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
                countView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            countView.heightAnchor.constraint(equalToConstant: screenHeight / 20)

        ])
    }
    
    @IBAction func closeTransactionsClicked(_ sender: Any) {
        send()
    }
    
    @objc func goBack() {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "AdminController") {
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true, completion: nil)
        }
    }
    
    func send(){
        var closeCompleted = false
        var transactions: [[String: Any]] = []
        var postString = "test"
        do {
            for row in try databaseController.database2.prepare(databaseController.transactionTable) {
                let transaction: [String: Any] = [
                    "amount": String(row[databaseController.amount]),
                    "pid": row[databaseController.passengerId]
                ]
                transactions.append(transaction)
            }

            let jsonObject: [String: Any] = [
                "flightNo": AdminController.flightNo,
                "transactions": transactions
            ]
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    postString = jsonString
                }
            } catch {
                print("Error converting JSON object to string: \(error)")
            }
        } catch {
            print("Error: \(error)")
        }
        
        var request = URLRequest(url: URL(string: "https://172.20.60.67:8080/close")!)
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error{
                print("error: ")
                print(error)
                return
            }
            if let data = data{
                guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                    fatalError("Couldn't access the document directory.")
                }
                let fileURL = documentsDirectory.appendingPathComponent("serverData.json")
                if FileManager.default.fileExists(atPath: fileURL.path) {
                    do {
                        try FileManager.default.removeItem(at: fileURL)
                    } catch {
                        fatalError("Failed to delete the file: \(error)")
                    }
                }
                do {
                    try data.write(to: fileURL, options: .atomic)
                    closeCompleted = true
                    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
                    let blurEffectView = UIVisualEffectView(effect: blurEffect)
                    blurEffectView.frame = self.view.bounds
                    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    self.view.addSubview(blurEffectView)
                    
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CompletedPopUp") as! CompletedPopUp
                    self.addChild(popOverVC)
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParent: self)
                    AdminController.flightNo = ""
                } catch {
                    fatalError("Failed to create the file: \(error)")
                }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                } catch {
                    print(error.localizedDescription)
                }
            }
            if let response = response{
            }
        }
        task.resume()
        if(closeCompleted == false){
            
        }
        databaseController.resetTransactions()

    }
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
            if challenge.protectionSpace.host == "172.20.60.67" {
                completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
            } else {
                completionHandler(.performDefaultHandling, nil)
            }
    }
    
}
