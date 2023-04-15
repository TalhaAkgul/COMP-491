//
//  QRCodeView.swift
//  passengerApp
//
//  Created by Doga Ege Inhanli on 15.04.2023.
//

import Foundation
import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCodeView : View {
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    var url : String
    
    var body: some View {
        Image(uiImage: generateQRCodeImage(url: url))
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200, alignment: .center)
    }
    
    func generateQRCodeImage( url : String) -> UIImage {
        let data = Data(url.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let qrCodeImage = filter.outputImage {
            if let qrCodeCGImage = context.createCGImage(qrCodeImage, from: qrCodeImage.extent) {
                return UIImage(cgImage: qrCodeCGImage)
            }
        }
        
        return UIImage(systemName: "xmark") ?? UIImage()
    }
}
