//
//  CachedAsyncImage.swift
//  Design
//
//  Created by Tom Knighton on 13/07/2025.
//

import Foundation
import UIKit
import SwiftUI

public struct CachedAsyncImage: View {
    
    @State private var uiImage: UIImage? = nil
    private let url: String
    
    public init(url: String) {
        self.url = url
    }
    
    public var body: some View {
        ZStack {
            if uiImage == nil {
                Rectangle()
                    .fill(Color.secondary)
                    .frame(height: 200)
                    .opacity(uiImage == nil ? 1 : 1)
            }
            if let uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .transition(.identity)
                    .animation(nil, value: uiImage)
                    .allowedDynamicRange(.constrainedHigh)
                    .transaction { transaction in
                        transaction.animation = nil
                    }
            }
            
        }
        .task {
            if uiImage == nil, let imageUrl = URL(string: url) {
                async let imageData = try? await ImageLoader.shared.loadImage(from: imageUrl, downsample: false)
                uiImage = await imageData
            }
        }
        .id("image")
        .transaction { transaction in
            transaction.animation = nil
            transaction.disablesAnimations = true
        }
    }
}
