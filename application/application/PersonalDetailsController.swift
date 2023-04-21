//
//  PersonalDetailsController.swift
//  application
//
//  Created by Doga Ege Inhanli on 8.04.2023.
//

import UIKit
import SQLite

class PersonalDetailsController: UIViewController, URLSessionDelegate {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func request(){
        let postString = "test"
        var request = URLRequest(url: URL(string: "https://172.16.146.4:8080/getalldata")!)
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error{
                print("error: ")
                print(error)
                return
            }
            if let data = data{
                print("data: ")
                print(data)
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error.localizedDescription)
                }
            }
            if let response = response{
                print("response: ")
                print(response)
            }
        }
        task.resume()
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
            if challenge.protectionSpace.host == "172.16.146.4" {
                completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
            } else {
                completionHandler(.performDefaultHandling, nil)
            }
    }
}
