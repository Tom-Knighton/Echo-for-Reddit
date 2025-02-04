// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension EchoAPI {
  class GetSubredditQuery: GraphQLQuery {
    public static let operationName: String = "GetSubreddit"
    public static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query GetSubreddit($name: String!) { reddit { __typename subreddit(subredditName: $name) { __typename ...SubredditFragment } } }"#,
        fragments: [SubredditFragment.self]
      ))

    public var name: String

    public init(name: String) {
      self.name = name
    }

    public var __variables: Variables? { ["name": name] }

    public struct Data: EchoAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { EchoAPI.Objects.Query }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("reddit", Reddit.self),
      ] }

      public var reddit: Reddit { __data["reddit"] }

      /// Reddit
      ///
      /// Parent Type: `RedditQuery`
      public struct Reddit: EchoAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { EchoAPI.Objects.RedditQuery }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("subreddit", Subreddit.self, arguments: ["subredditName": .variable("name")]),
        ] }

        public var subreddit: Subreddit { __data["subreddit"] }

        /// Reddit.Subreddit
        ///
        /// Parent Type: `SubredditDto`
        public struct Subreddit: EchoAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { EchoAPI.Objects.SubredditDto }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .fragment(SubredditFragment.self),
          ] }

          public var subredditId: String { __data["subredditId"] }
          public var subredditName: String { __data["subredditName"] }
          public var subredditTitle: String { __data["subredditTitle"] }
          public var subredditIconUrl: String? { __data["subredditIconUrl"] }
          public var userIsBanned: Bool { __data["userIsBanned"] }
          public var subredditSubscriberCount: Int { __data["subredditSubscriberCount"] }
          public var subredditIsNSFW: Bool { __data["subredditIsNSFW"] }
          public var subredditTagline: String { __data["subredditTagline"] }
          public var subredditDescription: String { __data["subredditDescription"] }
          public var userIsSubscribed: Bool { __data["userIsSubscribed"] }
          public var bannerImageUrl: String? { __data["bannerImageUrl"] }

          public struct Fragments: FragmentContainer {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public var subredditFragment: SubredditFragment { _toFragment() }
          }
        }
      }
    }
  }

}