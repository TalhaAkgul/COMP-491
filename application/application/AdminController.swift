//
//  AdminController.swift
//  application
//
//  Created by Doga Ege Inhanli on 21.05.2023.
//

import UIKit
import SQLite
import MultipeerConnectivity

class AdminController: UIViewController, URLSessionDelegate {
    
    @IBOutlet weak var connectCabinCrewButton: UIButton!
    @IBOutlet weak var getProvisionsButton: UIButton!
    @IBOutlet weak var closeTransactionsButton: UIButton!
    @IBOutlet weak var seeAllTransactionsButton: UIButton!
    @IBOutlet weak var resetTransactionsButton: UIButton!
    
    let sessionManager = SessionManager.shared
    var mcSession: MCSession!
    
    let databaseController = DatabaseController.instance
    
    static var flightNo = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseController.connectTransactionDatabase()
        mcSession = self.sessionManager.mcSession
        setItems()
        
    }
    
    @objc func goBack() {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "mainViewController") {
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true, completion: nil)
        }

    }
    
    func setItems(){
        let backgroundImage = UIImageView(image: UIImage(named: "images/entrance page images/entrance.png"))
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.frame = view.bounds
        backgroundImage.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundImage.center = view.center
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height
        
        let navigationItem = UINavigationItem(title: "Admin Page")
        
        let back = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                   style: .plain,
                                   target: self,
                                   action: #selector(goBack))
        navigationItem.leftBarButtonItem = back

        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: screenHeight/25, width: view.frame.width, height: 44))
        navigationBar.barTintColor = UIColor(white: 0.95, alpha: 1.0)
        navigationBar.setItems([navigationItem], animated: false)
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.tintColor = .white
        navigationBar.backgroundColor = .clear
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        view.addSubview(navigationBar)
        connectCabinCrewButton.center.x = self.view.center.x
        connectCabinCrewButton.center.y = self.view.center.y - screenHeight/20
        
        getProvisionsButton.center.x = self.view.center.x
        getProvisionsButton.center.y = connectCabinCrewButton.frame.maxY + getProvisionsButton.bounds.size.height
        
        closeTransactionsButton.center.x = self.view.center.x
        closeTransactionsButton.center.y = getProvisionsButton.frame.maxY + closeTransactionsButton.bounds.size.height
        
        seeAllTransactionsButton.center.x = self.view.center.x
        seeAllTransactionsButton.center.y = closeTransactionsButton.frame.maxY + seeAllTransactionsButton.bounds.size.height
        
        resetTransactionsButton.center.x = self.view.center.x
        resetTransactionsButton.center.y = seeAllTransactionsButton.frame.maxY + resetTransactionsButton.bounds.size.height
    }
   
    @IBAction func connectCabinCrewClicked(_ sender: Any) {
        sessionManager.connectDevice(fromViewController: self)
    }
    
    @IBAction func getProvisionsClicked(_ sender: Any) {
        print(AdminController.flightNo)
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "FlightNoEntry") {
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true, completion: nil)
        }
        print(AdminController.flightNo)
        if(AdminController.flightNo != ""){
            request()
        }
    }
    
    @IBAction func closeTransactionsClicked(_ sender: Any) {
        print(AdminController.flightNo)
        send()
    }
    
    @IBAction func seeAllTransactionsClicked(_ sender: Any) {
        
    }
    
    @IBAction func resetTransactionsClicked(_ sender: Any) {
        
        databaseController.resetTransactions()
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
                    print(jsonString)
                    postString = jsonString
                }
            } catch {
                print("Error converting JSON object to string: \(error)")
            }
        } catch {
            print("Error: \(error)")
        }
        
        var request = URLRequest(url: URL(string: "https://172.20.56.202:8080/close")!)
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
                print("data: ")
                print(data)
                
                guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                    fatalError("Couldn't access the document directory.")
                }
                let fileURL = documentsDirectory.appendingPathComponent("serverData.json")
                print(fileURL)
                // Check if the file already exists
                if FileManager.default.fileExists(atPath: fileURL.path) {
                    do {
                        try FileManager.default.removeItem(at: fileURL)
                        print("File 'serverData.json' deleted.")
                    } catch {
                        fatalError("Failed to delete the file: \(error)")
                    }
                }
                do {
                    try data.write(to: fileURL, options: .atomic)
                    print("New file 'serverData.json' created.")
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
                    print(json)
                } catch {
                    print(error.localizedDescription)
                }
            }
            if let response = response{
                print("response: ")
                print(response)
            }
        }
        task.resume()
        if(closeCompleted == false){
            
        }
    }
    func request(){
        var request = URLRequest(url: URL(string: "https://172.20.56.202:8080/getProvisionsByFlightNo?flightNo=" + AdminController.flightNo)!)
        request.httpMethod = "GET"
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error{
                print("error: ")
                print(error)
                return
            }
            if let data = data{
                print("data: ")
                print(data)
                
                guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                    fatalError("Couldn't access the document directory.")
                }
                let fileURL = documentsDirectory.appendingPathComponent("serverData.json")
                print(fileURL)
                if FileManager.default.fileExists(atPath: fileURL.path) {
                    do {
                        try FileManager.default.removeItem(at: fileURL)
                        print("File 'serverData.json' deleted.")
                    } catch {
                        fatalError("Failed to delete the file: \(error)")
                    }
                }
                do {
                    try data.write(to: fileURL, options: .atomic)
                    print("New file 'serverData.json' created.")
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
                } catch {
                    fatalError("Failed to create the file: \(error)")
                }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error.localizedDescription)
                }
            }
            if let response = response{
                print("response: ")
                print(response)
            }
        }
        task.resume()
    }
    
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
            if challenge.protectionSpace.host == "172.20.56.202" {
                completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
            } else {
                completionHandler(.performDefaultHandling, nil)
            }
    }
}
