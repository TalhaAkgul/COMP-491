//
//  ViewController.swift
//  application
//
//  Created by Doga Ege Inhanli on 28.03.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addBackground()
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        //Welcome Label
        
        let welcomeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth/2, height: screenHeight/20))
        
        welcomeLabel.center.x = self.view.center.x
        welcomeLabel.center.y = self.view.center.y + screenHeight/20
        welcomeLabel.textAlignment = .center
        welcomeLabel.text = "Welcome!"
        
        self.view.addSubview(welcomeLabel)
        
        //Identification label
        let identificationLabel = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight/20))
        identificationLabel.center.x = self.view.center.x
        identificationLabel.center.y = welcomeLabel.center.y + welcomeLabel.bounds.size.height
        identificationLabel.textAlignment = .center
        identificationLabel.text = "Please select your identification method below."
        self.view.addSubview(identificationLabel)
        
        //QR code button
        
         
    }
    
    
    
}

