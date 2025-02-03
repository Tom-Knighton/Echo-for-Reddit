//
//  UserStatsView.swift
//  User
//
//  Created by Tom Knighton on 03/02/2025.
//

import SwiftUI
import API
import Env

struct UserStatsView: View {
    
    @Environment(\.theme) private var theme
    let user: EchoAPI.UserFragment
    
    public var body: some View {
        ZStack {
            if let banner = user.userSubreddit.bannerImageUrl, let bannerURL = URL(string: banner) {
                AsyncImage(url: bannerURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, maxHeight: 384, alignment: .top)
                            .clipShape(.rect(cornerRadius: 10))
                        
                    default:
                        shim()
                    }
                }
            } else {
                shim()
            }
            
            HStack {
                userStat("Comment Karma", value: String(describing: user.commentKarma))
                Spacer()
                userStat("Post Karma", value: String(describing: user.postKarma))
                Spacer()
                userStat("Account Age", value: String(describing: user.createdAt.dynamicDateDifference))
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 16)
        }
    }
    
    @ViewBuilder
    private func shim() -> some View {
        Rectangle()
            .fill(theme.layer2)
            .frame(maxWidth: .infinity, maxHeight: 384)
            .clipShape(.rect(cornerRadius: 10))
            .shadow(radius: 3)
    }
    
    @ViewBuilder
    private func userStat(_ title: String, value: String) -> some View {
        VStack {
            Text(value)
                .font(.headline.bold())
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
            Text(title)
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Material.ultraThin)
        .clipShape(.rect(cornerRadius: 10))
    }
}
