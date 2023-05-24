//
//  IDViewController.swift
//  application
//
//  Created by Doga Ege Inhanli on 29.03.2023.
//

import UIKit
import AVFoundation
import Vision
class IDViewController: UIViewController,AVCaptureVideoDataOutputSampleBufferDelegate {
    var captureSession: AVCaptureSession!
        var videoPreviewLayer: AVCaptureVideoPreviewLayer!
        
        // Vision variables
        var textRecognitionRequest: VNRecognizeTextRequest!
    override func viewDidLoad() {
        super.viewDidLoad()
                self.view.backgroundColor = .green
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
                videoPreviewLayer.frame = view.layer.bounds
                view.layer.addSublayer(videoPreviewLayer)
        

          
    }
    func setupVision() {
            textRecognitionRequest = VNRecognizeTextRequest(completionHandler: { [weak self] request, error in
                guard let observations = request.results as? [VNRecognizedTextObservation] else {
                    return
                }
                //print(observations)
                for observation in observations {
                    guard let topCandidate = observation.topCandidates(1).first else { continue }
                    
                    // Process the recognized text here
                    //let identityNumber = topCandidate.string
                    //print("Identity Number: \(identityNumber)")
                    // Process the recognized text here
                                let text = topCandidate.string
                                
                                // Extract identity number
                                if let identityNumber = self?.extractIdentityNumber(from: text) {
                                    print("Identity Number: \(identityNumber)")
                                }
                }
            })
            
            textRecognitionRequest.recognitionLevel = .accurate
            textRecognitionRequest.usesLanguageCorrection = false
        }
    func extractIdentityNumber(from text: String) -> String? {
        // Implement your logic here to extract the identity number
        // You can use regular expressions, string manipulation, or other methods
        
        // Example: Extract the first 9-digit number
        let regex = try! NSRegularExpression(pattern: "\\d{11}")
        let matches = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
        if let match = matches.first {
            return String(text[Range(match.range, in: text)!])
        }
        
        return nil
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
        }

}
