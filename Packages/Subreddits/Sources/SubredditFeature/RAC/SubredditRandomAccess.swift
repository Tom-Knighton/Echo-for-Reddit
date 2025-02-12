//
//  SubredditRandomAccess.swift
//  Subreddits
//
//  Created by Tom Knighton on 09/02/2025.
//

import SwiftUI
import Models
import Combine

@Observable
final class SubredditDataSource: RandomAccessCollection, @unchecked Sendable {
    typealias Element = Post
    typealias Index = Int
    
    public var items: [Post] = []
    public var isLoading: Bool = false
    let threshold = 5
    
    let loadMoreSubject = PassthroughSubject<Void, Never>()
    
    public init(items: [Element]) {
        self.items = items
    }
    
    var startIndex: Int {
        items.startIndex
    }
    
    var endIndex: Int {
        items.endIndex
    }
    
    func formIndex(after i: inout Int) {
        i += 1
        
        if i >= (items.count - threshold) && !isLoading && !items.isEmpty {
            self.isLoading = true
            self.loadMoreSubject.send(())
        }
    }
    
    subscript(position: Int) -> Element { items[position] }
    
    public func appendAfterLoading(_ items: [Element]) {
        self.items.append(contentsOf: items)
        self.isLoading = false
    }
}
