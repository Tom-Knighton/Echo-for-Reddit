//
//  SubredditLink.swift
//  Design
//
//  Created by Tom Knighton on 23/03/2025.
//

import SwiftUI

public struct SubredditLink: View {
    
    private let subredditName: String
    
    public init(subredditName: String) {
        self.subredditName = subredditName
    }
    
    
    public var body: some View {
        GenericLinkView(subredditName, iconName: "r.circle") {
            //TODO:
        }
    }
}

#Preview {
    SubredditLink(subredditName: "Swift")
}
