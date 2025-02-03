//
//  DateTime.swift
//  API
//
//  Created by Tom Knighton on 03/02/2025.
//
import Foundation
import Apollo

nonisolated(unsafe) private let iso8601DateFormatter = ISO8601DateFormatter()

public extension EchoAPI {
    typealias DateTime = Date
}

extension Date: @retroactive AnyHashableConvertible {}
extension Date: @retroactive GraphQLOperationVariableValue {}
extension Date: @retroactive OutputTypeConvertible {}
extension Date: @retroactive JSONDecodable {}
extension Date: @retroactive AnyScalarType {}
extension Date: @retroactive JSONEncodable {}
extension EchoAPI.DateTime: @retroactive CustomScalarType {
    
    public init(_jsonValue value: JSONValue) throws {
        iso8601DateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        guard let string = value as? String else {
            throw JSONDecodingError.couldNotConvert(value: value, to: String.self)
        }
        
        guard let date = iso8601DateFormatter.date(from: string) else {
            throw JSONDecodingError.couldNotConvert(value: value, to: Date.self)
        }
        
        self = date
    }
    
    public var _jsonValue: JSONValue {
        return iso8601DateFormatter.string(from: self)
    }
    
}
