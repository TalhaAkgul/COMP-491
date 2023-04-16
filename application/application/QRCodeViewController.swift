//
//  QRCodeViewController.swift
//  application
//
//  Created by Doga Ege Inhanli on 29.03.2023.
//

import UIKit
import SwiftUI
import CodeScanner

class QRCodeViewController: UIViewController {
    
    var scannedCode: String = ""
    var scanComplete: bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        var scannerSheet : some View {
            CodeScannerView(
                codeTypes: [.qr],
                completion: {result in
                    if case let .success(code) = result{
                        self.scannedCode = "\(code)"
                        self.scanComplete = true
                        print(self.scannedCode)
                    }
                }
            )
        }
        let scanView = UIHostingController(rootView: scannerSheet)
        //scanView.view.translatesAutoresizingMaskIntoConstraints = false
        scanView.view.frame = self.view.bounds
        self.view.addSubview(scanView.view)
        self.addChild(scanView)
        
        
    }
}





