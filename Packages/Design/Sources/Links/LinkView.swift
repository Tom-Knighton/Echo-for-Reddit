//
//  LinkView.swift
//  Design
//
//  Created by Tom Knighton on 08/02/2025.
//

import Env
import SwiftUI
@preconcurrency import OpenGraphReader
@preconcurrency import LinkPresentation

public struct OGLinkView: View {
    
    private var url: String
    private var previewImage: ImageData?
    private var aspectRatio: Double = 16/9
    
    @Environment(\.colorScheme) private var colorScheme
    @State private var data = OpenGraphData()
    @State private var uiImage: UIImage? = nil
    @State private var textColour: Color = Color.primary
    @State private var imageColour: Color = Color.secondary
    
    public struct ImageData {
        let imageUrl: String
        let imageHeight: Double
        let imageWidth: Double
    }
    
    public init(url: String, previewImage: ImageData? = nil) {
        self.url = url
        self.previewImage = previewImage
        if let previewImage {
            self.aspectRatio = previewImage.imageWidth / previewImage.imageHeight
        }
    }
    
    public init(data: OpenGraphData) {
        self._data = State(wrappedValue: data)
        self.url = data.link?.absoluteString ?? ""
    }

    public var body: some View {
        VStack {
            Group {
                if let url = data.link, let subreddit = url.extractSubreddit() {
                    SubredditLink(subredditName: subreddit)
                } else if let url = data.link, isSocialLink(url) {
                    twitterView(for: data)
                } else {
                    VStack(spacing: 0) {
                        image()
                        
                        VStack {
                            if let title = data.title {
                                Text(title)
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .multilineTextAlignment(.leading)
                                    .font(.headline)
                                    .foregroundStyle(self.textColour)
                            }
                            if let url = data.link {
                                Text(url.host() ?? url.absoluteString)
                                    .lineLimit(1)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.subheadline)
                                    .foregroundStyle(self.textColour)
                            }
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(self.imageColour)
                    }
                }
            }
            .clipShape(.rect(cornerRadius: 10))
            .cornerRadius(15)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .task {
            if data.link == nil {
                await fetchData()
            }
        }
        .task(id: data.link) {
            if uiImage == nil, let imageUrl = data.imageURL {
                async let imageData = try? await ImageLoader.shared.loadImage(from: imageUrl)
                uiImage = await imageData
                self.textColour = Color(uiImage?.bestTextColor ?? .label)
                self.imageColour = Color(uiImage?.prominentColor ?? .secondarySystemBackground)
            }
        }
    }
    
    @ViewBuilder
    private func image() -> some View {
        Group {
            ZStack {
                if uiImage == nil {
                    Rectangle()
                        .fill(Color.secondary)
                        .frame(height: 200)
                        .opacity(uiImage == nil ? 1 : 1)
                }
                if let uiImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .clipped()
                        .transition(.identity)
                        .animation(nil, value: uiImage)
                        .transaction { transaction in
                            transaction.animation = nil
                        }
                }
            }
        }
        .id("image")
        .transaction { transaction in
            transaction.animation = nil
            transaction.disablesAnimations = true
        }
    }
    
    @ViewBuilder
    private func twitterView(for data: OpenGraphData) -> some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                
                Text(data.title ?? "")
                    .bold()
                Text((data.description ?? "").truncate(length: 250))
                
                if useImageUrl(for: data), let image = data.imageURL {
                    AsyncImage(url: image, transaction: .init(animation: nil)) { phase in
                        switch phase {
                        case .success(let img):
                            img
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxHeight: 250)
                                .clipShape(.rect(cornerRadius: 12))
                        default:
                            Rectangle()
                        }
                    }
                }
                
                Text(data.link?.host() ?? "")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .multilineTextAlignment(.leading)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background(
            Rectangle()
                .foregroundStyle(backgroundColor())
                .background(.ultraThinMaterial)
        )
    }
    
    private func useImageUrl(for data: OpenGraphData) -> Bool {
        if data.imageURL?.absoluteString.contains("profile_images") == true {
            return false
        }
        
        return true
    }
        
    private func fetchData() async {
        guard let url = URL(string: self.url) else { return }
        
        let reader = OpenGraphReader()
        
        var request = URLRequest(url: url)
        request.addValue("facebookexternalhit/1.1", forHTTPHeaderField: "User-Agent")
        let openGraphResponse = try? await reader.fetch(request: request)
        
        if let openGraphResponse {
            
            var useImageUrl = true
            
            if openGraphResponse.url?.absoluteString.contains("x.com") == true {
                if openGraphResponse.imageURL?.absoluteString.contains("profile_images") == true {
                    useImageUrl = false
                }
            }
            
            
            let data = OpenGraphData(
                title: openGraphResponse.title,
                link: openGraphResponse.url ?? url,
                type: openGraphResponse.type,
                siteName: openGraphResponse.siteName,
                description: openGraphResponse.description,
                imageURL: useImageUrl ? openGraphResponse.imageURL : nil,
                siteIconUrl: nil
            )
            
            
            self.data = data
        }
    }
    
    private func backgroundColor() -> Color {
        let url = self.data.link?.absoluteString ?? ""
        
        if url.contains("x.com") || url.contains("twitter.com") {
            return Color.blue.opacity(colorScheme == .dark ? 0.3 : 0.7)
        }
        
        if url.contains("bsky.app") {
            return Color(0x0a78ff)
        }
        
        return Color.gray.opacity(colorScheme == .dark ? 0.3 : 0.7)
    }
    
    func isSocialLink(_ url: URL) -> Bool {
        guard let host = url.host else { return false }
        let socialDomains = ["twitter.com", "x.com", "bsky.app"]
        return socialDomains.contains { host.contains($0) }
    }
}

extension String {
    func truncate(length: Int) -> String {
        return (self.count > length) ? self.prefix(length) + "..." : self
    }
}


#Preview {
    List {
        VStack {
            OGLinkView(url: "https://x.com/Keir_Starmer/status/1891611103937036516")
            OGLinkView(url: "https://x.com/YouGov/status/1891818765404471598")
            
        }
        .listRowInsets(.init())
        
    }
    .listStyle(.plain)
    .padding(.horizontal)
    
}
