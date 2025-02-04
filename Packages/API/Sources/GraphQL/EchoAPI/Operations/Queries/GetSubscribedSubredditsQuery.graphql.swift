// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension EchoAPI {
  class GetSubscribedSubredditsQuery: GraphQLQuery {
    public static let operationName: String = "GetSubscribedSubreddits"
    public static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query GetSubscribedSubreddits { reddit { __typename subscribed { __typename ...SubscribedSubredditFragment } } }"#,
        fragments: [SubscribedSubredditFragment.self]
      ))

    public init() {}

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
          .field("subscribed", [Subscribed].self),
        ] }

        public var subscribed: [Subscribed] { __data["subscribed"] }

        /// Reddit.Subscribed
        ///
        /// Parent Type: `SubredditDto`
        public struct Subscribed: EchoAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { EchoAPI.Objects.SubredditDto }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .fragment(SubscribedSubredditFragment.self),
          ] }

          public var subredditId: String { __data["subredditId"] }
          public var subredditTitle: String { __data["subredditTitle"] }
          public var subredditIconUrl: String? { __data["subredditIconUrl"] }

          public struct Fragments: FragmentContainer {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public var subscribedSubredditFragment: SubscribedSubredditFragment { _toFragment() }
          }
        }
      }
    }
  }

}