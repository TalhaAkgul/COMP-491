//
//  ViewController.swift
//  application
//
//  Created by Doga Ege Inhanli on 28.03.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var identifyIdButton: UIButton!
    @IBOutlet weak var qrCodeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addBackground()
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height
        
        //Welcome Label
        welcomeLabel.center.x = self.view.center.x
        welcomeLabel.center.y = self.view.center.y + screenHeight/20
        welcomeLabel.textAlignment = .center
        
        //Identification Label
        
        instructionLabel.center.x = self.view.center.x
        instructionLabel.center.y = welcomeLabel.center.y + welcomeLabel.bounds.size.height
        instructionLabel.textAlignment = .center
        
        //ID Button
        identifyIdButton.center.x = self.view.center.x
        identifyIdButton.center.y = instructionLabel.center.y +
        2.5*instructionLabel.bounds.size.height
       
        //Qr Code Button
        qrCodeButton.center.x = self.view.center.x
        qrCodeButton.center.y = identifyIdButton.center.y + 1.25*qrCodeButton.bounds.size.height
    }
}

