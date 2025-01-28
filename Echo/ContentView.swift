//
//  ContentView.swift
//  Echo
//
//  Created by Tom Knighton on 27/01/2025.
//

import SwiftUI
import Onboarding
import API

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Logged In")
            Button(action: { Task {
                await AuthManager().logout()
            }}) {
                Text("Log Out")
            }
        }
    }
}

#Preview {
    ContentView()
}
