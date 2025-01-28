//
//  AuthToken.swift
//  API
//
//  Created by Tom Knighton on 27/01/2025.
//

import Foundation

public struct AuthToken: Codable, Sendable {
    
    public let Token: String
    public let RefreshToken: String
    public let ExpiryDate: Date
    
    public func IsValid() -> Bool {
        return ExpiryDate > Date()
    }
    
    public static func buildFromOauthResponse(_ oauth: OAuthResponse) -> AuthToken {
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .second, value: 59, to: Date()) ?? Date()
        
        let newToken: AuthToken = AuthToken(Token: oauth.accessToken, RefreshToken: oauth.refreshToken, ExpiryDate: date)
        return newToken
    }
}

public struct OAuthResponse: Codable, Sendable {
    
    public let accessToken: String
    public let refreshToken: String
}
