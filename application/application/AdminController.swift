//
//  AdminController.swift
//  application
//
//  Created by Doga Ege Inhanli on 21.05.2023.
//

import UIKit
import SQLite
import MultipeerConnectivity

class AdminController: UIViewController {
    @IBOutlet weak var connectCabinCrewButton: UIButton!
    @IBOutlet weak var getProvisionsButton: UIButton!
    @IBOutlet weak var closeTransactionsButton: UIButton!
    @IBOutlet weak var seeAllTransactionsButton: UIButton!
    @IBOutlet weak var resetTransactionsButton: UIButton!
    
    var database2: Connection!
    let transactionTable = Table("Transaction")
    let transactionId = Expression<String>("transactionId")
    let amount = Expression<Double>("amount")
    let passengerId = Expression<String>("passengerId")
    
    let sessionManager = SessionManager.shared
    var mcSession: MCSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeTransactionDatabase()
        mcSession = self.sessionManager.mcSession
        setItems()
        
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
    
    func initializeTransactionDatabase(){
        
        
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
            let fileUrl = documentDirectory.appendingPathComponent("Transaction").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database2 = database
        } catch {
            print(error)
        }
    }
    
    @IBAction func connectCabinCrewClicked(_ sender: Any) {
        sessionManager.connectDevice(fromViewController: self)
    }
    
    @IBAction func getProvisionsClicked(_ sender: Any) {
    }
    
    @IBAction func closeTransactionsClicked(_ sender: Any) {
    }
    
    @IBAction func seeAllTransactionsClicked(_ sender: Any) {
    }
    
    @IBAction func resetTransactionsClicked(_ sender: Any) {
        do {
            let drop = transactionTable.drop(ifExists: true)
            try database2.run(drop)
        } catch {
            print(error)
        }
        let createTable = self.transactionTable.create { (table) in
            table.column(self.transactionId, primaryKey: true)
            table.column(self.amount)
            table.column(self.passengerId)
        }
                        
        do {
            try self.database2.run(createTable)
            print("Created Table")
        } catch {
            print(error)
        }
    }
}
