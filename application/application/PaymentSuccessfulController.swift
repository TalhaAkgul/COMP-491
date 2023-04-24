//
//  PaymentSuccessfulController.swift
//  application
//
//  Created by Doga Ege Inhanli on 10.04.2023.
//

import UIKit

class PaymentSuccessfulController: UIViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        showAnimate()
        /*
        let delay : Double = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = storyBoard.instantiateViewController(withIdentifier: "mainViewController") as! ViewController
            mainViewController.modalPresentationStyle = .fullScreen
                    self.present(mainViewController, animated: true, completion: nil)
         
        }
         */
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
         
}
