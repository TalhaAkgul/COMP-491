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
        let delay : Double = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = storyBoard.instantiateViewController(withIdentifier: "mainViewController") as! ViewController
            mainViewController.modalPresentationStyle = .fullScreen
                    self.present(mainViewController, animated: true, completion: nil)
        }
    }
}
