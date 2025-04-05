//
//  SubredditLink.swift
//  Design
//
//  Created by Tom Knighton on 23/03/2025.
//

import SwiftUI
import Env

public struct SubredditLink: View {
    
    @Environment(Router.self) private var router
    
    private let subredditName: String
    
    public init(subredditName: String) {
        self.subredditName = subredditName
    }
    
    public var body: some View {
        GenericLinkView(subredditName, iconName: "r.circle") {
            router.push(.subreddit(subredditName: subredditName))
        }
    }
}

#Preview {
    SubredditLink(subredditName: "Swift")
}
