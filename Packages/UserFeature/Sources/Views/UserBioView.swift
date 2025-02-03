//
//  UserBioView.swift
//  User
//
//  Created by Tom Knighton on 03/02/2025.
//

import SwiftUI
import API

struct UserBioView: View {
    
    let description: String
    
    var body: some View {
        Text("About:")
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.callout.bold())
        Text(description)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
    }
}
