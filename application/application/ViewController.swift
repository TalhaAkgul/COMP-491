//
//  ViewController.swift
//  application
//
//  Created by Doga Ege Inhanli on 28.03.2023.
//

import UIKit
import SQLite
import MultipeerConnectivity

class ViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var identifyIdButton: UIButton!
    @IBOutlet weak var qrCodeButton: UIButton!
    @IBOutlet weak var syncButton: UIButton!
    
    let sessionManager = SessionManager.shared
    var mcSession: MCSession!
    
    let databaseController = DatabaseController.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseController.initializeMenuDatabase()
        databaseController.connectTransactionDatabase()
        databaseController.initializeQRDatabase()
        mcSession = self.sessionManager.mcSession
        //databaseController.resetTransactions()
        let backgroundImage = UIImageView(image: UIImage(named: "images/entrance page images/entrance.png"))
                backgroundImage.contentMode = .scaleAspectFill
                backgroundImage.frame = view.bounds
                backgroundImage.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                backgroundImage.center = view.center
                view.addSubview(backgroundImage)
                view.sendSubviewToBack(backgroundImage)
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height
        
        welcomeLabel.center.x = self.view.center.x
        welcomeLabel.center.y = self.view.center.y + screenHeight/20
        welcomeLabel.textAlignment = .center
        
        instructionLabel.center.x = self.view.center.x
        instructionLabel.center.y = welcomeLabel.center.y + welcomeLabel.bounds.size.height
        instructionLabel.textAlignment = .center
        
        identifyIdButton.center.x = self.view.center.x
        identifyIdButton.center.y = instructionLabel.center.y +
        2.5*instructionLabel.bounds.size.height
       
        qrCodeButton.center.x = self.view.center.x
        qrCodeButton.center.y = identifyIdButton.center.y + 1.25*qrCodeButton.bounds.size.height
        
        syncButton.center.x = self.view.center.x
        syncButton.center.y = qrCodeButton.center.y + 2*syncButton.bounds.size.height
    }
}

