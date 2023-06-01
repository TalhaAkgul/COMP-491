//
//  FlightNoEntry.swift
//  application
//
//  Created by Doga Ege Inhanli on 23.05.2023.
//

import UIKit

class FlightNoEntry: UIViewController, UITextViewDelegate, URLSessionDelegate {
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
        if(AdminController.flightNo != ""){
            request()
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.alpha = 1.0
    }
    
    func request(){
        var request = URLRequest(url: URL(string: "https://172.16.126.233:8080/getProvisionsByFlightNo?flightNo=" + AdminController.flightNo)!)
        request.httpMethod = "GET"
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error{
                print("error: ")
                print(error)
                return
            }
            if let data = data{
                guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                    fatalError("Couldn't access the document directory.")
                }
                let fileURL = documentsDirectory.appendingPathComponent("serverData.json")
                if FileManager.default.fileExists(atPath: fileURL.path) {
                    do {
                        try FileManager.default.removeItem(at: fileURL)
                    } catch {
                        fatalError("Failed to delete the file: \(error)")
                    }
                }
                do {
                    try data.write(to: fileURL, options: .atomic)
                    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
                    let blurEffectView = UIVisualEffectView(effect: blurEffect)
                    blurEffectView.frame = self.view.bounds
                    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    self.view.addSubview(blurEffectView)
                    
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CompletedPopUp") as! CompletedPopUp
                    self.addChild(popOverVC)
                    popOverVC.view.frame = self.view.frame
                    self.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParent: self)
                } catch {
                    fatalError("Failed to create the file: \(error)")
                }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                } catch {
                    print(error.localizedDescription)
                }
            }
            if let response = response{
            }
        }
        task.resume()
    }
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
            if challenge.protectionSpace.host == "172.16.126.233" {
                completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
            } else {
                completionHandler(.performDefaultHandling, nil)
            }
    }
}
