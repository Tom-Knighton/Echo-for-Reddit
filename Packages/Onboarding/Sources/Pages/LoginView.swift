//
//  LoginView.swift
//  Onboarding
//
//  Created by Tom Knighton on 27/01/2025.
//

import SwiftUI
import Env
import API

let symbols = Array(repeating: "arrow.up", count: 150)
let columns = [
    GridItem(.adaptive(minimum: 50))
]

public struct LoginView: View {
    @Environment(\.theme) private var theme
    
    public init() {}
    
    public var body: some View {
        ZStack {
            MeshGradient(width: 2, height: 2, points: [
                [0, 0], [1, 0],
                [0, 1], [1, 1]
            ], colors: [
                .orange, .orange,
                theme.scheme == .dark ? .black : .purple, theme.scheme == .dark ? .gray : .pink
            ])
            .overlay {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(symbols.indices, id: \.self) { index in
                        Image(systemName: symbols[index])
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .bold()
                            .foregroundStyle(Material.regular)
                    }
                }
            }
            .drawingGroup()
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                VStack {
                    Text("Login to Reddit")
                        .font(.title.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button(action: {}) {
                        Text("Why do I have to login?")
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.blue)
                    }
                    
                    Spacer()
                    Button(action: { Task {
                        try await AuthManager().beginOAuthFlow()
                    }}) {
                        Text("Login Now")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .bold()
                            .foregroundStyle(.white)
                            .background(theme.tint)
                            .clipShape(.rect(cornerRadius: 10))
                    }
                    Spacer().frame(height: 16)
                }
                .padding(16)
                .frame(height: 200, alignment: .bottom)
                .background(Material.regular)
                .clipShape(.rect(cornerRadius: 10))
                .padding(.horizontal, 16)
                Spacer().frame(height: 16)
            }
            .onOpenURL { url in
                if url.host() == "echo-oauth-callback" {
                    AuthManager().handleOauth(response: url)
                }
            }
        }
    }
}

#Preview {
    LoginView()
        .applyTheme()
}
