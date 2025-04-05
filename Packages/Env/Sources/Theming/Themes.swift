//
//  Themes.swift
//  Design
//
//  Created by Tom Knighton on 27/01/2025.
//

import SwiftUI

public let availableThemes: [ThemePair] = [
    .init(light: EchoLightTheme(), dark: EchoDarkTheme())
]

public struct ThemePair: Identifiable, Sendable {
    public var id: String {
        dark.name.rawValue + light.name.rawValue
    }
    
    public let light: Theme
    public let dark: Theme
}

public struct EchoLightTheme: Theme {
    public var name: ThemeName = .light
    public var scheme: ColorScheme = .light
    public var tint: Color = .blue
    public var primaryBackground: Color = .init(0xFAFAFA)
    public var layer2: Color = .init(0xEEEEEE)
    public var layer3: Color = .init(0xE0E0E0)
    public var labelColor: Color = .black
    
    public init() {}
}

public struct EchoDarkTheme: Theme {
    public var name: ThemeName = .dark
    public var scheme: ColorScheme = .dark
    public var tint: Color = .blue
    public var primaryBackground: Color = .init(0x101010)
    public var layer2: Color = .init(0x181818)
    public var layer3: Color = .init(0x2c2c2c)
    public var labelColor: Color = .white
    
    public init() {}
}
