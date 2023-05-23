//
//  FlightNoEntry.swift
//  application
//
//  Created by Doga Ege Inhanli on 23.05.2023.
//

import UIKit

class FlightNoEntry: UIViewController, UITextViewDelegate {
    @IBOutlet weak var flightEntryTextView: UITextView!
    @IBOutlet weak var continueButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(image: UIImage(named: "images/entrance page images/entrance.png"))
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.frame = view.bounds
        backgroundImage.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundImage.center = view.center
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
        flightEntryTextView.delegate = self
        flightEntryTextView.text = "Please enter the flight number!"
        flightEntryTextView.alpha = 0.5
        flightEntryTextView.backgroundColor = .clear
        flightEntryTextView.textColor = .white
        
        continueButton.center.x = self.view.center.x
        continueButton.center.y = flightEntryTextView.frame.maxY + continueButton.bounds.size.height
    }
    
    @IBAction func continueButtonClicked(_ sender: Any) {
        if(flightEntryTextView.text != "Please enter the flight number!"){
            AdminController.flightNo = flightEntryTextView.text
        }
        
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "AdminController") {
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true, completion: nil)
        }
        print(AdminController.flightNo)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.alpha = 1.0
    }
}
