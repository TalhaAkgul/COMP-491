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
    @IBOutlet weak var foodMenuView: UIView!
    @IBOutlet weak var entertainmentMenuView: UIView!
    @IBOutlet weak var afterFlightServicesView: UIView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var scrollView: UIScrollView!
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
        
            let scrollViewContainer: UIStackView = {
                let view = UIStackView()

                view.axis = .vertical
                view.spacing = 10

                view.translatesAutoresizingMaskIntoConstraints = false
                return view
            }()

        let myView: UIView = {
            let view = UIView(frame: CGRect(x: 100, y: 100, width: 50, height: 60))
            view.backgroundColor = .red
            view.heightAnchor.constraint(equalToConstant: scrollView.bounds.size.width).isActive = true
                return view
            }()
        view.addSubview(scrollView)
                scrollView.addSubview(scrollViewContainer)
                scrollViewContainer.addArrangedSubview(myView)
                /*
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
                scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
                */
                scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
                scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
                scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
                scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
               
                 // this is important for scrolling
                scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
    }
    
}
