//
//  PersonalDetailsController.swift
//  application
//
//  Created by Doga Ege Inhanli on 8.04.2023.
//

import UIKit
import SQLite



class PersonalDetailsController: UIViewController, URLSessionDelegate {
 
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
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var personalInfoView: UIView!
    @IBOutlet weak var spendingsView: UIView!
    @IBOutlet weak var initialPLabel: UITextField!
    @IBOutlet weak var idLabel: UITextField!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var provisionLabel: UITextField!
    @IBOutlet weak var addPaymentButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        connectDatabase()
        connectDatabase2()
        readLocalData()
        do {
            // Retrieve the first row from the QR table
            if let qrRow = try database3.pluck(qrTable) {
                // Retrieve the value of pId column from the row and assign it to idLabel's text
                idLabel.text = qrRow[pId]
                
            }
        } catch {
            print("Error retrieving data: \(error)")
        }
        idLabel.isUserInteractionEnabled = false
        nameLabel.isUserInteractionEnabled = false
        provisionLabel.isUserInteractionEnabled = false
        initialPLabel.isUserInteractionEnabled = false
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height
        let screenWidth  = screenSize.width
        personalInfoView.frame.size.width = screenWidth * 0.9
        personalInfoView.center.x = self.view.center.x
        personalInfoView.center.y = navigationBar.center.y +  navigationBar.bounds.size.height + screenHeight/25
        
        spendingsView.frame.size.width = screenWidth * 0.9
        spendingsView.center.x = self.view.center.x
        spendingsView.center.y = personalInfoView.frame.maxY + spendingsView.bounds.size.height/2 + screenHeight/25
        
        addPaymentButton.frame.size.width = screenWidth * 0.9
        addPaymentButton.center.x = self.view.center.x
        addPaymentButton.center.y = spendingsView.frame.maxY + addPaymentButton.bounds.size.height/2 + screenHeight/25
        
        cancelButton.frame.size.width = screenWidth * 0.9
        cancelButton.center.x = self.view.center.x
        cancelButton.center.y = addPaymentButton.frame.maxY + cancelButton.bounds.size.height/2 + screenHeight/25
        
        
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
    
    func readLocalData(){
        guard let path = Bundle.main.path(forResource: "serverData", ofType: "json") else {
            fatalError("Couldn't find file 'serverData.json' in app bundle.")
        }
        
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            print(data)
            do {
                let decoder = JSONDecoder()
                let serverInfos = try decoder.decode([ServerData].self, from: data)
                var currentId = ""
                if let qrRow = try database3.pluck(qrTable) {
                    // Retrieve the value of pId column from the row and assign it to idLabel's text
                    currentId  = qrRow[pId]
                }
                for serverInfo in serverInfos {
                    if serverInfo.passengerId == currentId {
                        let passengerId = serverInfo.passengerId
                        let passengerName = serverInfo.passengerName
                        let passengerSurname = serverInfo.passengerSurname
                        let amount = serverInfo.amount
                        var totalSpendings = 0.0
                        /*
                        do {
                            let filteredRows = try database2.prepare(transactionTable.filter(passengerId == currentId))
                            for row in filteredRows {
                                let transactionAmount = Double(row[amount])
                                totalSpendings += transactionAmount
                            }
                        } catch {
                            print("Error selecting transactions: \(error)")
                        }
*/
                        nameLabel.text = passengerName + " " + passengerSurname
                        provisionLabel.text = amount + "₺"
                        initialPLabel.text = amount + "₺"
                    }
                        }
                    } catch {
                      print(error)
                    }        } catch {
            fatalError("Couldn't load contents of file at path '\(url)': \(error)")
        }
    }

    func request(){
        let postString = "test"
        var request = URLRequest(url: URL(string: "https://172.16.146.4:8080/getalldata")!)
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: String.Encoding.utf8)
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
            if challenge.protectionSpace.host == "172.16.146.4" {
                completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
            } else {
                completionHandler(.performDefaultHandling, nil)
            }
    }
    
    func connectDatabase(){
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("QR").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database3 = database
        } catch {
            print(error)
        }
    }
}
