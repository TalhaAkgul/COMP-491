//
//  CompletedPopUp.swift
//  application
//
//  Created by Doga Ege Inhanli on 23.05.2023.
//

import UIKit

class CompletedPopUp: UIViewController{
    
    @IBOutlet weak var completedLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        showAnimate()
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
