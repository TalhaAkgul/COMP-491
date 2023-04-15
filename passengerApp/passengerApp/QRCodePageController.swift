//
//  QRCodePageController.swift
//  QRCodeApplication
//
//  Created by Doga Ege Inhanli on 11.04.2023.
//

import UIKit
import PassKit

class QRCodePageController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAnimate()
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
