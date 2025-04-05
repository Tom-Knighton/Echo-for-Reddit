//
//  GenericLink.swift
//  Design
//
//  Created by Tom Knighton on 23/03/2025.
//
import Env
import SwiftUI

@MainActor
public struct GenericLinkView: View {
    
    @Environment(\.theme) private var theme
    @Environment(\.openURL) private var openURL

    private let link: String
    private let iconName: String
    private let onClick: (() -> Void)?
    
    public init(_ link: String, iconName: String = "network", onClick: (() -> Void)? = nil) {
        self.link = link
        self.iconName = iconName
        self.onClick = onClick
    }

    public var body: some View {
        HStack {
            Image(systemName: iconName)
            Divider()
            Text(link)
                .lineLimit(1)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(theme.layer3)
        .clipShape(.rect(cornerRadius: 10))
        .shadow(radius: 3)
        .onTapGesture {
            if let onClick {
                onClick()
            } else {
                if let url = URL(string: link) {
                    self.openURL(url)
                }
            }
        }
    }
}
