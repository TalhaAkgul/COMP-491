//
//  AddPaymentController.swift
//  application
//
//  Created by Doga Ege Inhanli on 3.04.2023.
//

import UIKit

class AddPaymentController: UIViewController {
    
    @IBOutlet weak var menuImage1: UIImageView!
    @IBOutlet weak var menuImage2: UIImageView!
    @IBOutlet weak var menuImage3: UIImageView!
    @IBOutlet weak var menuImage4: UIImageView!
    @IBOutlet weak var menuImage5: UIImageView!
    @IBOutlet weak var menuImage6: UIImageView!
    @IBOutlet weak var menuImage7: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = .red
        menuImage1.image = UIImage(named: "images/add payment page images/menu1.jpeg")
        menuImage2.image = UIImage(named: "images/add payment page images/menu2.jpeg")
        menuImage3.image = UIImage(named: "images/add payment page images/menu3.jpeg")
        menuImage4.image = UIImage(named: "images/add payment page images/menu4.jpeg")
        menuImage5.image = UIImage(named: "images/add payment page images/menu5.jpeg")
        menuImage6.image = UIImage(named: "images/add payment page images/menu6.jpeg")
        menuImage7.image = UIImage(named: "images/add payment page images/menu7.jpeg")
        
    }
    
}
