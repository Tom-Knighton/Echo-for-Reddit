//
//  ThemeApplier.swift
//  Env
//
//  Created by Tom Knighton on 27/01/2025.
//
import SwiftUI

extension View {
    public func applyTheme() -> some View {
        self.modifier(ThemeApplier())
    }
}

@MainActor
struct ThemeApplier: ViewModifier {
    @AppStorage("theme_pair_id") private var themePairId: String = availableThemes.first!.id
    @Environment(\.colorScheme) private var colourScheme
    @State private var theme: Theme = EchoLightTheme()
    
    func body(content: Content) -> some View {
        content
            .tint(theme.tint)
//            .foregroundStyle(theme.labelColor)
            .environment(\.theme, theme)
            .fontDesign(.rounded)
            .onChange(of: colourScheme, initial: true) { _, newVal in
                let themePair = availableThemes.first(where: { $0.id == themePairId })
                guard let themePair else { fatalError("Failed to read themes") }
                
                self.theme = newVal == .dark ? themePair.dark : themePair.light
            }
    }
}
