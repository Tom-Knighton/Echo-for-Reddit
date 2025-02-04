//
//  UIImage+Color.swift
//  Design
//
//  Created by Tom Knighton on 04/02/2025.
//
import UIKit

extension UIImage {
    
    var averageBrightness: CGFloat? {
        guard let inputImage = CIImage(image: self) else { return nil }
        
        let extentVector = CIVector(x: inputImage.extent.origin.x,
                                    y: inputImage.extent.origin.y,
                                    z: inputImage.extent.size.width,
                                    w: inputImage.extent.size.height)
        
        guard let filter = CIFilter(name: "CIAreaAverage",
                                    parameters: [kCIInputImageKey: inputImage,
                                                kCIInputExtentKey: extentVector]),
              let outputImage = filter.outputImage else { return nil }
        
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull!])
        context.render(outputImage,
                       toBitmap: &bitmap,
                       rowBytes: 4,
                       bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                       format: .RGBA8,
                       colorSpace: nil)
        
        let red   = CGFloat(bitmap[0]) / 255.0
        let green = CGFloat(bitmap[1]) / 255.0
        let blue  = CGFloat(bitmap[2]) / 255.0
        
        let brightness = (red * 0.299) + (green * 0.587) + (blue * 0.114)
        return brightness
    }
    
    var bestTextColor: UIColor? {
        let threshold: CGFloat = 0.5
        
        if let brightness = averageBrightness {
            return brightness > threshold ? .black : .white
        } else {
            return nil
        }
    }
}
