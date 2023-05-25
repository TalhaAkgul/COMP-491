//
//  PersonalDetailsController.swift
//  application
//
//  Created by Doga Ege Inhanli on 8.04.2023.
//

import UIKit
import SQLite


class PersonalDetailsController: UIViewController {
    
    @IBOutlet weak var personalInfoView: UIView!
    @IBOutlet weak var spendingsView: UIView!
    @IBOutlet weak var initialPLabel: UITextField!
    @IBOutlet weak var spentLabel: UITextField!
    @IBOutlet weak var idLabel: UITextField!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var provisionLabel: UITextField!
    @IBOutlet weak var addPaymentButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var seeAllSpendingsButton: UIButton!
    
    let databaseController = DatabaseController.instance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseController.connectQRDatabase()
        databaseController.connectTransactionDatabase()
        
        readLocalData()
        setItems()
    }
    
    
    func setItems(){
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height
        let screenWidth  = screenSize.width
        let navigationItem = UINavigationItem(title: "Personal Details")
        
        let back = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                   style: .plain,
                                   target: self,
                                   action: #selector(goBack))
        navigationItem.leftBarButtonItem = back

        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: screenHeight/25, width: view.frame.width, height: 44))
        navigationBar.barTintColor = UIColor(white: 0.95, alpha: 1.0)
        navigationBar.setItems([navigationItem], animated: false)

        view.addSubview(navigationBar)
        
        idLabel.isUserInteractionEnabled = false
        nameLabel.isUserInteractionEnabled = false
        provisionLabel.isUserInteractionEnabled = false
        initialPLabel.isUserInteractionEnabled = false
        
        do {
            if let qrRow = try databaseController.database3.pluck(databaseController.qrTable) {
                idLabel.text = qrRow[databaseController.pId]
            }
        } catch {
            print("Error retrieving data: \(error)")
        }
        
        
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
        initialPLabel.isUserInteractionEnabled = false
        provisionLabel.isUserInteractionEnabled = false
        spentLabel.isUserInteractionEnabled = false
    }
    
    @objc func goBack() {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "mainViewController") {
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true, completion: nil)
        }

    }
    
    @IBAction func seeSpendingDetailsClicked(_ sender: UIButton) {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SpendingDetailsController") as! SpendingDetailsController
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }
    
    func readLocalData(){
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Couldn't access the document directory.")
        }
        
        let fileURL = documentsDirectory.appendingPathComponent("serverData.json")
        print(fileURL)
        do {
            let rows = try databaseController.database3.prepare(databaseController.qrTable)
                for row in rows {
                    let pIdValue = row[databaseController.pId]
                    let prIdValue = row[databaseController.prId]
                    let prCountValue = row[databaseController.prCount]
                    
                    print("pId: \(pIdValue), prId: \(prIdValue), prCount: \(prCountValue)")
                }
            } catch {
                print("Error printing rows: \(error)")
            }
        do {
            let data = try Data(contentsOf: fileURL)
            print(data)
            do {
                let decoder = JSONDecoder()
                print("DKDKDS")
                let serverInfos = try decoder.decode([ServerData].self, from: data)
                print("DKDKDS2")
                print(serverInfos)
                var currentId = ""
                if let qrRow = try databaseController.database3.pluck(databaseController.qrTable) {
                    currentId  = qrRow[databaseController.pId]
                    print(currentId)
                }
                var passengerFound = false
                print("beforeserverinfo")
                for serverInfo in serverInfos {
                    print("ifffff")
                    print(serverInfo.passengerPID)
                    print(type(of: serverInfo.passengerPID))
                    print(type(of: currentId))
                    print(currentId)
                   
                    if serverInfo.passengerPID == currentId {
                        passengerFound = true
                        let passengerName = serverInfo.passengerName
                        let passengerSurname = serverInfo.passengerSurname
                        print("SDAS111111111")
                        let provisionAmount = Double(serverInfo.amount) ?? 0.0
                        print("SDAS2222222")
                        print(provisionAmount)
                        var totalSpendings = 0.0
                        
                        do {
                            let filteredRows = try databaseController.database2.prepare(databaseController.transactionTable.filter(databaseController.passengerId == currentId))
                            for row in filteredRows {
                                let transactionAmount = Double(row[databaseController.amount])
                                totalSpendings += transactionAmount
                            }
                        } catch {
                            print("Error selecting transactions: \(error)")
                        }
                        print(totalSpendings)
                        let remainingAmount = provisionAmount - totalSpendings
                        nameLabel.text = passengerName + " " + passengerSurname
                        provisionLabel.text = String(remainingAmount) + "₺"
                        initialPLabel.text = String(provisionAmount) + "₺"
                        spentLabel.text = String(totalSpendings) + "₺"
                        if(totalSpendings == 0.0){
                            seeAllSpendingsButton.isEnabled = false
                        } else {
                            seeAllSpendingsButton.isEnabled = true
                        }
                    }
                    
                        }
                if(passengerFound == false){
                    print("no passenger found")
                    let personalDetailsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainViewController") as! PersonalDetailsController
                    self.addChild(personalDetailsController)
                    personalDetailsController.view.frame = self.view.frame
                    self.view.addSubview(personalDetailsController.view)
                    personalDetailsController.didMove(toParent: self)
                    
                }
                    } catch {
                      print(error)
                    }        } catch {
                            fatalError("Couldn't load contents of file at path '\(fileURL)': \(error)")
        }
    }
}
