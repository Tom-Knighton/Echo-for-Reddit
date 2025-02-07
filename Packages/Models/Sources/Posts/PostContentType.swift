//
//  PostContentType.swift
//  Models
//
//  Created by Tom Knighton on 06/02/2025.
//

public enum PostContentType: String {
    case textOnly = "TEXT_ONLY"
    case image = "IMAGE"
    case video = "VIDEO"
    case gif = "GIF"
    case linkOnly = "LINK_ONLY"
    case mediaGallery = "MEDIA_GALLERY"
}

extension PostContentType: Sendable {}
