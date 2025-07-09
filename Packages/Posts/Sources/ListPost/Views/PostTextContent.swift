//
//  PostTextContent.swift
//  Posts
//
//  Created by Tom Knighton on 08/02/2025.
//

import SwiftUI
import Models
import Env
import RedditMarkdownView

public struct PostTextContent: View {
    
    @Environment(\.theme) private var theme
    public let textContent: String
    
    public var body: some View {
        Spacer().frame(height: 4)
        
        SnudownView(text: textContent)
            .snudownTextColor(Color.gray)
            .snudownDisplayInlineImages(false)
            .snudownShowInlineImageLinks(false)
            .snudownHideTables(true)
            .snudownMaxCharacters(150)
            .lineLimit(5)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
