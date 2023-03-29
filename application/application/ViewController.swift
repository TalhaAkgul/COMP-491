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
        
        
        //Qr Code Button
        let qrCodeButton = UIButton(frame: CGRect(x:0, y:0, width:screenWidth/2, height:screenHeight/20))
        qrCodeButton.center.x = self.view.center.x
        qrCodeButton.center.y = identificationLabel.center.y + identificationLabel.bounds.size.height
        let heightQRButton = qrCodeButton.bounds.size.height
        qrCodeButton.layer.cornerRadius = heightQRButton/2
        qrCodeButton.layer.borderWidth = 1
        qrCodeButton.layer.borderColor = UIColor.white.cgColor
        qrCodeButton.setTitle("Scan QR Code", for: .normal)
        qrCodeButton.addTarget(self, action: #selector(qrCodeButtonClicked), for: .touchUpInside)
        view.addSubview(qrCodeButton)
        
        //ID Button
        let IDButton = UIButton(frame: CGRect(x:0, y:0, width:screenWidth/2, height:screenHeight/20))
        IDButton.center.x = self.view.center.x
        IDButton.center.y = qrCodeButton.center.y + 1.25*qrCodeButton.bounds.size.height
        let heightIDButton = qrCodeButton.bounds.size.height
        IDButton.layer.cornerRadius = heightIDButton/2
        IDButton.layer.borderWidth = 1
        IDButton.layer.borderColor = UIColor.white.cgColor
        IDButton.setTitle("Scan ID Card", for: .normal)
        IDButton.addTarget(self, action: #selector(IDButtonClicked), for: .touchUpInside)
        view.addSubview(IDButton)
    }
    
    @objc func qrCodeButtonClicked(){
        let qrCodeViewController = QRCodeViewController()
        qrCodeViewController.modalPresentationStyle = .overFullScreen
        present(qrCodeViewController, animated: true, completion: nil)
    }
    
    @objc func IDButtonClicked(){
        let IDViewController = IDViewController()
        IDViewController.modalPresentationStyle = .overFullScreen
        present(IDViewController, animated: true, completion: nil)
    }
    
}

