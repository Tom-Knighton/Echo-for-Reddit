//
//  Theme.swift
//  Design
//
//  Created by Tom Knighton on 27/01/2025.
//
import SwiftUI

public protocol Theme: Sendable {
    var name: ThemeName { get }
    var scheme: ColorScheme { get }
    var tint: Color { get }
    var primaryBackground: Color { get }
    var layer2: Color { get }
    var layer3: Color { get }
    var labelColor: Color { get }
}

public enum ThemeName: String, CaseIterable, Sendable {
    case light = "Echo - Light"
    case dark = "Echo - Dark"
}
