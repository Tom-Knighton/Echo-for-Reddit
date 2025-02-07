//
//  PostContent.swift
//  Models
//
//  Created by Tom Knighton on 06/02/2025.
//

public struct PostContent {
    public let textContent: String?
    public let contentType: PostContentType
    public let media: [PostMedia]
    
    public init(textContent: String?, contentType: PostContentType, media: [PostMedia]) {
        self.textContent = textContent
        self.contentType = contentType
        self.media = media
    }
}

extension PostContent: Sendable, Equatable {
    
}
