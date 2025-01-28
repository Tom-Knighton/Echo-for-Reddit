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
    public var primaryBackground: Color = .white
    public var layer2: Color = .white
    public var layer3: Color = .white
    public var labelColor: Color = .black
    
    public init() {}
}

public struct EchoDarkTheme: Theme {
    public var name: ThemeName = .dark
    public var scheme: ColorScheme = .dark
    public var tint: Color = .blue
    public var primaryBackground: Color = .black
    public var layer2: Color = .black
    public var layer3: Color = .black
    public var labelColor: Color = .white
    
    public init() {}
}
