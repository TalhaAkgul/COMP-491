//
//  IDViewController.swift
//  application
//
//  Created by Doga Ege Inhanli on 29.03.2023.
//

import UIKit
import AVFoundation
import Vision
import SQLite

class IDViewController: UIViewController,AVCaptureVideoDataOutputSampleBufferDelegate {
    var captureSession: AVCaptureSession!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var textRecognitionRequest: VNRecognizeTextRequest!
    var identityNumberList: [String] = []
    let databaseController = DatabaseController.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height
        let screenWidth  = screenSize.width
        let navigationItem = UINavigationItem(title: "Scan ID Card")
        
        let back = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                   style: .plain,
                                   target: self,
                                   action: #selector(goBack))
        navigationItem.leftBarButtonItem = back

        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: screenHeight/25, width: view.frame.width, height: 44))
        navigationBar.barTintColor = UIColor(white: 0.95, alpha: 1.0)
        navigationBar.setItems([navigationItem], animated: false)

        view.addSubview(navigationBar)
         
                captureSession = AVCaptureSession()
                
                guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
                    fatalError("Failed to get the camera device")
                }
                
                guard let videoInput = try? AVCaptureDeviceInput(device: videoCaptureDevice) else {
                    fatalError("Failed to create the camera input")
                }
        setupVision()
                captureSession.addInput(videoInput)
                
                let videoOutput = AVCaptureVideoDataOutput()
                videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue.global(qos: .userInitiated))
                captureSession.addOutput(videoOutput)
                
                captureSession.startRunning()
                
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer.frame = CGRect(x: 0, y: navigationBar.frame.height + screenHeight/25, width: view.layer.bounds.width, height: view.layer.bounds.height - navigationBar.frame.height)
                view.layer.addSublayer(videoPreviewLayer)
        

          
    }
    @objc func goBack() {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "mainViewController") {
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true, completion: nil)
        }
    }
    func setupVision() {
            textRecognitionRequest = VNRecognizeTextRequest(completionHandler: { [weak self] request, error in
                guard let observations = request.results as? [VNRecognizedTextObservation] else {
                    return
                }
                for observation in observations {
                    guard let topCandidate = observation.topCandidates(1).first else { continue }
                    let text = topCandidate.string
                    if let identityNumber = self?.extractIdentityNumber(from: text) {
                        self?.identityNumberList.append(identityNumber)
                    }
                }
            })
            
            textRecognitionRequest.recognitionLevel = .accurate
            textRecognitionRequest.usesLanguageCorrection = false
        }
    func extractIdentityNumber(from text: String) -> String? {
        let regex = try! NSRegularExpression(pattern: "\\d{11}")
        let matches = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
        if let match = matches.first {
            return String(text[Range(match.range, in: text)!])
        }
        return nil
    }
    func movePage(controllerName : String){
        let personalDetailsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: controllerName) as! PersonalDetailsController
        self.addChild(personalDetailsController)
        personalDetailsController.view.frame = self.view.frame
        self.view.addSubview(personalDetailsController.view)
        personalDetailsController.didMove(toParent: self)
    }
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
            guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
                return
            }
            
            let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .right, options: [:])
            
            do {
                try imageRequestHandler.perform([textRecognitionRequest])
            } catch {
                print("Error: \(error)")
            }
            DispatchQueue.main.async { [weak self] in
                if self?.identityNumberList.count == 50 {
                if let mostRepeatedIdentityNumber = self?.findMostRepeatedString() {
                    self?.captureSession.stopRunning()
                    let insertQuery = self?.databaseController.qrTable.insert((self?.databaseController.pId <- mostRepeatedIdentityNumber)!, (self?.databaseController.prId <- String(-1))!, (self?.databaseController.prCount <- String(-1))!)
                    do {
                        try self?.databaseController.database3.run(insertQuery!)
                    } catch {
                        print("Error inserting data: \(error)")
                    }
                    self?.movePage(controllerName: "PersonalDetailsController")
                    
                } else {
                    self?.movePage(controllerName: "mainViewController")
                }
                self?.identityNumberList.removeAll()
                }
            }
    }
    
    func findMostRepeatedString() -> String? {
            // Count the occurrences of each string in the identityNumberList
            var countDictionary: [String: Int] = [:]
            
            for identityNumber in identityNumberList {
                if let count = countDictionary[identityNumber] {
                    countDictionary[identityNumber] = count + 1
                } else {
                    countDictionary[identityNumber] = 1
                }
            }
            
            // Find the string with the highest count
            var mostRepeatedString: String?
            var highestCount = 0
            
            for (identityNumber, count) in countDictionary {
                if count > highestCount {
                    highestCount = count
                    mostRepeatedString = identityNumber
                }
            }
            
            return mostRepeatedString
        }
}
