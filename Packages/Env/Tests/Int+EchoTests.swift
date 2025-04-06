//
//  Test.swift
//  Env
//
//  Created by Tom Knighton on 02/04/2025.
//

import Testing
import Foundation
import Env

@Suite("Int+Echo Tests")
struct IntTests {
    
    private static let extractTestArguments: [ExtractTestPair] = [
        .init(100, "100"),
        .init(132, "132"),
        .init(100_000, "100K"),
        .init(1_000, "1K"),
        .init(1_000_000, "1M"),
        .init(1_300_000, "1.3M"),
        .init(1_350_000, "1.35M"),
    ]
    

    @Test("Extracts subreddit successfully in a range of scenarios", arguments: extractTestArguments)
    func testExtractSubredditIsSuccessful(_ data: ExtractTestPair) async throws {
        // Act
        let result = data.input.toFriendly()
        
        // Assert
        #expect(result == data.expected, "Expected \(data.expected ?? "nil") but got \(result ?? "nil")")
    }

    
    struct ExtractTestPair: Identifiable {
        
        let input: Int
        let expected: String
        let id: String
        
        public init(_ input: Int, _ expected: String) {
            self.input = input
            self.expected = expected
            self.id = "\(input)-\(expected)"
        }
    }
}
