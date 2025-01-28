//
//  EchoApp.swift
//  Echo
//
//  Created by Tom Knighton on 27/01/2025.
//

import SwiftUI
import Env
import API
import Onboarding
import Combine

@main
struct EchoApp: App {
    
    @State private var isLoading = true
    @State private var isLoggedIn = false
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                } else if isLoggedIn {
                    ContentView()
                } else {
                    LoginView()
                }
            }
            .applyTheme()
            .task {
                await doLoginWork()
            }
            .onReceive(NotificationCenter.default.publisher(for: .didLogout)) { out in
                self.isLoggedIn = false
            }
            .onReceive(NotificationCenter.default.publisher(for: .didLogin)) { out in
                Task {
                    await doLoginWork()
                }
            }
        }
    }
    
    private func doLoginWork() async {
        let authManager = AuthManager()
        if let _ = try? await authManager.validToken() {
            isLoggedIn = true
        }
        
        isLoading = false
    }
}
