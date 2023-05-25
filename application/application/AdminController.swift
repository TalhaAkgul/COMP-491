//
//  AdminController.swift
//  application
//
//  Created by Doga Ege Inhanli on 21.05.2023.
//

import UIKit
import SQLite
import MultipeerConnectivity

class AdminController: UIViewController, URLSessionDelegate {
    
    @IBOutlet weak var connectCabinCrewButton: UIButton!
    @IBOutlet weak var getProvisionsButton: UIButton!
    @IBOutlet weak var closeTransactionsButton: UIButton!
    @IBOutlet weak var seeAllTransactionsButton: UIButton!
    @IBOutlet weak var resetTransactionsButton: UIButton!
    
    let sessionManager = SessionManager.shared
    var mcSession: MCSession!
    
    let databaseController = DatabaseController.instance
    
    static var flightNo = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseController.connectTransactionDatabase()
        mcSession = self.sessionManager.mcSession
        setItems()
        
    }
    
    @objc func goBack() {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "mainViewController") {
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true, completion: nil)
        }

    }
    
    func setItems(){
        let backgroundImage = UIImageView(image: UIImage(named: "images/entrance page images/entrance.png"))
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.frame = view.bounds
        backgroundImage.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundImage.center = view.center
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height
        
        let navigationItem = UINavigationItem(title: "Admin Page")
        
        let back = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                   style: .plain,
                                   target: self,
                                   action: #selector(goBack))
        navigationItem.leftBarButtonItem = back

        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: screenHeight/25, width: view.frame.width, height: 44))
        navigationBar.barTintColor = UIColor(white: 0.95, alpha: 1.0)
        navigationBar.setItems([navigationItem], animated: false)
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.tintColor = .white
        navigationBar.backgroundColor = .clear
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        view.addSubview(navigationBar)
        connectCabinCrewButton.center.x = self.view.center.x
        connectCabinCrewButton.center.y = self.view.center.y - screenHeight/20
        
        getProvisionsButton.center.x = self.view.center.x
        getProvisionsButton.center.y = connectCabinCrewButton.frame.maxY + getProvisionsButton.bounds.size.height
        
        closeTransactionsButton.center.x = self.view.center.x
        closeTransactionsButton.center.y = getProvisionsButton.frame.maxY + closeTransactionsButton.bounds.size.height
        
        seeAllTransactionsButton.center.x = self.view.center.x
        seeAllTransactionsButton.center.y = closeTransactionsButton.frame.maxY + seeAllTransactionsButton.bounds.size.height
        
        resetTransactionsButton.center.x = self.view.center.x
        resetTransactionsButton.center.y = seeAllTransactionsButton.frame.maxY + resetTransactionsButton.bounds.size.height
    }
   
    @IBAction func connectCabinCrewClicked(_ sender: Any) {
        sessionManager.connectDevice(fromViewController: self)
    }
    
    @IBAction func getProvisionsClicked(_ sender: Any) {
        print(AdminController.flightNo)
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "FlightNoEntry") {
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true, completion: nil)
        }
        print(AdminController.flightNo)
        
    }
    
    @IBAction func closeTransactionsClicked(_ sender: Any) {
        sessionManager.sendSyncRequest()
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "CloseController") {
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true, completion: nil)
        }
        
        print(AdminController.flightNo)
        
    }
    
    @IBAction func seeAllTransactionsClicked(_ sender: Any) {
        
    }
    
    @IBAction func resetTransactionsClicked(_ sender: Any) {
        
        databaseController.resetTransactions()
    }
    
    
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
            if challenge.protectionSpace.host == "172.20.62.133" {
                completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
            } else {
                completionHandler(.performDefaultHandling, nil)
            }
    }
}
