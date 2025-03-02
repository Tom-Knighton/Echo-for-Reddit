//
//  LinkView.swift
//  Design
//
//  Created by Tom Knighton on 08/02/2025.
//

import SwiftUI
@preconcurrency import OpenGraph
@preconcurrency import OpenGraphReader
@preconcurrency import LinkPresentation

public struct OpenGraphData: Sendable {
    let title: String?
    let link: URL?
    let type: String?
    let siteName: String?
    let description: String?
    let imageURL: URL?
    let siteIconUrl: URL?
    
    public init(title: String? = nil, link: URL? = nil, type: String? = nil, siteName: String? = nil, description: String? = nil, imageURL: URL? = nil, siteIconUrl: URL? = nil) {
        self.title = title
        self.link = link
        self.type = type
        self.siteName = siteName
        self.description = description
        self.imageURL = imageURL
        self.siteIconUrl = siteIconUrl
    }
}

public struct OGLinkView: View {
    
    private var url: String
    private var previewImage: ImageData?
    private var aspectRatio: Double = 16/9
    
    @Environment(\.colorScheme) private var colorScheme
    @State private var data = OpenGraphData()
    @State private var uiImage: UIImage? = nil
    
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
                if data.link?.absoluteString.contains("x.com") == true {
                    twitterView(for: data)
                } else {
                    VStack(spacing: 0) {
                        if let uiImage {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } else {
                            Rectangle()
                                .frame(maxWidth: .infinity)
                                .frame(height: 200)
                        }
                        
                        VStack {
                            if let title = data.title {
                                Text(title)
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .multilineTextAlignment(.leading)
                                    .foregroundStyle(Color(uiColor: uiImage?.bestTextColor ?? .label))
                            }
                            if let url = data.link {
                                Text(url.host() ?? url.absoluteString)
                                    .lineLimit(1)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.subheadline)
                                    .foregroundStyle(Color(uiColor: uiImage?.bestTextColor ?? .label).tertiary)
                            }
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(infoBackground())
                    }
                }
            }
            .clipShape(.rect(cornerRadius: 10))
            .cornerRadius(15)
            .transition(.scale(scale: 0.0, anchor: .top).combined(with: .opacity))
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .task {
            if data.link == nil {
                await fetchData()
            }
        }
        .task(id: data.link) {
            if uiImage == nil, let imageUrl = data.imageURL {
                uiImage = try? await ImageLoader.shared.loadImage(from: imageUrl)
            }
        }
    }
    
    @ViewBuilder
    private func infoBackground() -> some View {
        if let uiImage {
            Color(uiColor: uiImage.prominentColor ?? .red)
        } else {
            Color.blue
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
                    AsyncImage(url: image) { img in
                        img
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(.rect(cornerRadius: 12))
                    } placeholder: {
                        Rectangle()
                    }
                }
            }
            .multilineTextAlignment(.leading)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background(
            Rectangle()
                .foregroundStyle(Color.blue.opacity(colorScheme == .dark ? 0.3 : 0.7))
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
        
        if uiImage == nil, let imageUrl = data.imageURL {
            uiImage = try? await ImageLoader.shared.loadImage(from: imageUrl)
        }
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
