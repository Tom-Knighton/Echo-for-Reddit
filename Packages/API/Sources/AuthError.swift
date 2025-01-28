//
//  AuthError.swift
//  API
//
//  Created by Tom Knighton on 27/01/2025.
//
import Foundation

public enum APIError : Error {
    case missingToken
    case invalidBaseUrl
    case invalidToken
    case couldNotParse
}
