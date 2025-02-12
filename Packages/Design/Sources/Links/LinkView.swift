//
//  LinkView.swift
//  Design
//
//  Created by Tom Knighton on 08/02/2025.
//

import SwiftUI
@preconcurrency import OpenGraph
@preconcurrency import LinkPresentation

public struct OpenGraphData {
    var title: String?
    var link: URL?
    var type: String?
    var siteName: String?
    var description: String?
    var imageURL: URL?
    
    public init(title: String? = nil, link: URL? = nil, type: String? = nil, siteName: String? = nil, description: String? = nil, imageURL: URL? = nil) {
        self.title = title
        self.link = link
        self.type = type
        self.siteName = siteName
        self.description = description
        self.imageURL = imageURL
    }
}


public struct LinkView: View {
    @State private var metadata: LPLinkMetadata
    
    
    public init(metadata: LPLinkMetadata) {
        self.metadata = metadata
    }
    
    public var body: some View {
        VStack {
            LinkPreviewRepresentable(data: metadata)
                .id(metadata.url?.absoluteString)
                .frame(maxWidth: .infinity, maxHeight: 250)
                .aspectRatio(contentMode: .fill)
                .cornerRadius(15)
                .transition(.scale(scale: 0.0, anchor: .top).combined(with: .opacity))
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}


struct LinkPreviewRepresentable: UIViewRepresentable {
    let data: LPLinkMetadata
    
    func makeUIView(context: Context) -> UIView {
        let linkView = CustomLinkView()
        linkView.metadata = data
        linkView.sizeToFit()
        return linkView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) { }
    
    func sizeThatFits(_ proposal: ProposedViewSize, uiView: LPLinkView, context: Context) -> CGSize? {
        // The proposed width is the containing frame's width, if one is available use that width,
        // otherwise fallback to the custom view's intrinsic width
        let width = proposal.width ?? uiView.intrinsicContentSize.width
        
        // The proposed height is the containing frame's height which is going to be way to big.
        // So use the view's intrinsic height otherwise fallback to the smallest.
        let height = min(proposal.height ?? .infinity, uiView.intrinsicContentSize.height)
        return CGSize(width: width, height: height)
    }
}

class CustomLinkView: LPLinkView {
    
    init() {
        super.init(frame: .zero)
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
}

func checkForFirstUrl(text: String) -> URL? {
    let types: NSTextCheckingResult.CheckingType = .link
    
    do {
        let detector = try NSDataDetector(types: types.rawValue)
        let matches = detector.matches(in: text, options: .reportCompletion, range: NSMakeRange(0, text.count))
        if let firstMatch = matches.first {
            return firstMatch.url
        }
    } catch {
        print("")
    }
    
    return nil
}

public struct OGLinkView: View {
    
    private var url: String
    @State private var data = OpenGraphData()
    
    public init(url: String) {
        self.url = url
    }
    
    public init(data: OpenGraphData) {
        self._data = State(wrappedValue: data)
        self.url = data.link?.absoluteString ?? ""
    }
    
    
    public var body: some View {
        VStack {
            if let url = data.imageURL {
                AsyncImage(url: url) { img in
                    img
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } placeholder: {
                    ProgressView()
                }
                
                VStack {
                    if let title = data.title {
                        Text(title)
                            .bold()
                    }
                    if let desc = data.description {
                        Text(desc)
                    }
                    if let url = data.link {
                        Text(url.absoluteString)
                    }
                }
                .frame(maxWidth: .infinity)
                .background(Color.red)
            }
        }
        .task {
            if data.link == nil {
                await fetchData()
            }
        }
    }
    
    private func fetchData() async {
        do {
            guard let url = URL(string: self.url) else { return }
            
            let openGraph = try await OpenGraph.fetch(url: url)
            
            let data = OpenGraphData(
                title: openGraph[.title],
                link: URL(string: openGraph[.url] ?? ""),
                type: openGraph[.type],
                siteName: openGraph[.siteName],
                description: openGraph[.description],
                imageURL: URL(string: openGraph[.image] ?? "")
            )
            
            self.data = data
        } catch {
            print(error)
        }
    }
}
