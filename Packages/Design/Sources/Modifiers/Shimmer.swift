//
//  Shimmer.swift
//  Design
//
//  Created by Tom Knighton on 10/02/2025.
//

import SwiftUI

extension View {
    public func shimmer() -> some View {
        modifier(Shimmer())
    }
}

struct Shimmer: ViewModifier {
    
    @State var isInitialState: Bool = true
    
    public func body(content: Content) -> some View {
        content
            .mask {
                LinearGradient(
                    gradient: .init(colors: [.black.opacity(0.4), .black, .black.opacity(0.4)]),
                    startPoint: (isInitialState ? .init(x: -0.3, y: -0.3) : .init(x: 1, y: 1)),
                    endPoint: (isInitialState ? .init(x: 0, y: 0) : .init(x: 1.3, y: 1.3))
                )
            }
            .animation(.linear(duration: 1.5).delay(0.25).repeatForever(autoreverses: false), value: isInitialState)
            .onAppear() {
                isInitialState = false
            }
    }
}
