//
//  UIImage+Color.swift
//  Design
//
//  Created by Tom Knighton on 04/02/2025.
//
@preconcurrency import UIKit

extension UIImage {
    
    private static let sharedCgContext = CGContext(data: nil,
                                                   width: 1,
                                                   height: 1,
                                                   bitsPerComponent: 8,
                                                   bytesPerRow: 4,
                                                   space: CGColorSpaceCreateDeviceRGB(),
                                                   bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)
    
    
    private var averageBrightness: CGFloat? {
        guard let cgImage = self.cgImage else { return nil }
        
        guard let ctx = UIImage.sharedCgContext else { return nil }
        
        ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: 1, height: 1))
        guard let pixelData = ctx.data else { return nil }
        
        let data = pixelData.bindMemory(to: UInt8.self, capacity: 4)
        let red   = CGFloat(data[0]) / 255.0
        let green = CGFloat(data[1]) / 255.0
        let blue  = CGFloat(data[2]) / 255.0
        
        return (red * 0.299) + (green * 0.587) + (blue * 0.114)
    }
    
    public var bestTextColor: UIColor {
        let threshold: CGFloat = 0.7
        if let brightness = averageBrightness {
            return brightness > threshold ? .black : .white
        }
        return .label
    }
    
    public var prominentColor: UIColor? {
        guard let cgImage = self.cgImage else { return nil }
        
        guard let context = UIImage.sharedCgContext else { return nil }
        
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: 1, height: 1))
        guard let pixelData = context.data else { return nil }
        
        let data = pixelData.bindMemory(to: UInt8.self, capacity: 4)
        return UIColor(red: CGFloat(data[0]) / 255.0,
                       green: CGFloat(data[1]) / 255.0,
                       blue: CGFloat(data[2]) / 255.0,
                       alpha: CGFloat(data[3]) / 255.0)
    }
}
