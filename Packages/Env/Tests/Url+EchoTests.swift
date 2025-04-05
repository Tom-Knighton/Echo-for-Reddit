//
//  Test.swift
//  Env
//
//  Created by Tom Knighton on 02/04/2025.
//

import Testing
import Foundation
import Env

@Suite("Url+Echo Tests")
struct UrlTests {
    
    private static let extractTestArguments: [ExtractTestPair] = [
        .init("https://www.reddit.com/r/aww/", "aww"),
        .init("https://www.reddit.com/r/aww?testingId=1111&someOtherParam=true", "aww"),
        .init("http://www.reddit.com/r/aww", "aww"),
        .init("www.reddit.com/r/aww", "aww"),
        .init("reddit.com/r/aww", "aww"),
        .init("https://reddit.com/r/aww", "aww"),
        .init("/r/aww", "aww"),
        .init("r/aww", "aww"),
        .init("R/aww", "aww"),
        .init("REDDIT.COM/R/AWW", "AWW"),
        .init("https://www.reddit.com/r/reddit/", "reddit"),
        .init("/r/redditsecurity/comments/pfyqqn/covid_denialism_and_policy_clarifications/", "redditsecurity"),
    ]
    

    @Test("Extracts subreddit successfully in a range of scenarios", arguments: extractTestArguments)
    func testExtractSubredditIsSuccessful(_ data: ExtractTestPair) async throws {
        // Arrange
        let url = URL(string: data.input)!
        
        // Act
        let result = url.extractSubreddit()
        
        // Assert
        #expect(result == data.expected, "Expected \(data.expected ?? "nil") but got \(result ?? "nil")")
    }

    
    struct ExtractTestPair: Identifiable {
        
        let input: String
        let expected: String?
        let id: String
        
        public init(_ input: String, _ expected: String? = nil) {
            self.input = input
            self.expected = expected
            self.id = input + (expected ?? "")
        }
    }
}
