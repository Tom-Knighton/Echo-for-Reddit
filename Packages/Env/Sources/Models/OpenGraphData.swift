//
//  OpenGraphData.swift
//  Env
//
//  Created by Tom Knighton on 23/03/2025.
//

import Foundation

public struct OpenGraphData: Sendable {
    public let title: String?
    public let link: URL?
    public let type: String?
    public let siteName: String?
    public let description: String?
    public let imageURL: URL?
    public let siteIconUrl: URL?
    
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
