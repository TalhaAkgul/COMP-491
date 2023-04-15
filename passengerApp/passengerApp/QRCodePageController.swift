//
//  QRCodePageController.swift
//  QRCodeApplication
//
//  Created by Doga Ege Inhanli on 11.04.2023.
//

import UIKit
import PassKit
import SQLite
import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

class QRCodePageController: UIViewController {
    
    
    @IBOutlet weak var qrCodeImageView: UIImageView!
    let filter = CIFilter.qrCodeGenerator()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        showAnimate()
        let str = "dskds"
        generateQRCode(Data: str)
        
        
    }
    
    func generateQRCode(Data:String){
        let data = Data.data(using: String.Encoding.ascii, allowLossyConversion: false)
        
        filter.setValue(data, forKey: "InputMessage")
        
        let ciImage = filter.outputImage
        
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let transformImage = ciImage?.transformed(by: transform)
        
        let image = UIImage(ciImage: transformImage!)
        qrCodeImageView.image = image
    }
    
    @IBAction func closeClicked(_ sender: UIButton) {
        removeAnimate()
    }
    
    @IBAction func addWalletClicked(_ sender: UIButton) {
        
    }
    
   
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.view.removeFromSuperview()
                }
        });
    }
}
