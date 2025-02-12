//
//  PostTextContent.swift
//  Posts
//
//  Created by Tom Knighton on 08/02/2025.
//

import SwiftUI
import Models
import Env

public struct PostTextContent: View {
    
    @Environment(\.theme) private var theme
    public let textContent: String
    
    public var body: some View {
        Spacer().frame(height: 4)
        Text(textContent.truncate(length: 150))
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(theme.labelColor.secondary)
    }
}
