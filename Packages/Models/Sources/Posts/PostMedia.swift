//
//  PostMedia.swift
//  Models
//
//  Created by Tom Knighton on 06/02/2025.
//

public struct PostMedia {
    public let url: String
    public let thumbnailUrl: String?
    public let height: Double
    public let width: Double
    public let hlsDashUrl: String?
    public let mediaText: String?
    public let isInline: Bool
    public let type: PostContentType?
    
    public init(url: String, thumbnailUrl: String?, height: Double, width: Double, hlsDashUrl: String?, mediaText: String?, isInline: Bool, type: PostContentType?) {
        self.url = url
        self.thumbnailUrl = thumbnailUrl
        self.height = height
        self.width = width
        self.hlsDashUrl = hlsDashUrl
        self.mediaText = mediaText
        self.isInline = isInline
        self.type = type
    }
}

extension PostMedia: Equatable, Sendable {}
