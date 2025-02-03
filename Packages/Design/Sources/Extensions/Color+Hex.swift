//
//  Color+Hex.swift
//  Design
//
//  Created by Tom Knighton on 03/02/2025.
//

import SwiftUI

extension Color {
    public init(_ hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0xFF00) >> 8) / 255.0
        let blue = Double((hex & 0xFF) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
