// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension EchoAPI {
  class GetCurrentUserQuery: GraphQLQuery {
    public static let operationName: String = "GetCurrentUser"
    public static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query GetCurrentUser { reddit { __typename me { __typename ...UserFragment } } }"#,
        fragments: [UserFragment.self]
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
          .field("me", Me.self),
        ] }

        public var me: Me { __data["me"] }

        /// Reddit.Me
        ///
        /// Parent Type: `UserDto`
        public struct Me: EchoAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { EchoAPI.Objects.UserDto }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .fragment(UserFragment.self),
          ] }

          public var id: String { __data["id"] }
          public var name: String { __data["name"] }
          public var iconImageUrl: String { __data["iconImageUrl"] }
          public var totalKarma: Int { __data["totalKarma"] }
          public var postKarma: Int { __data["postKarma"] }
          public var commentKarma: Int { __data["commentKarma"] }
          public var createdAt: EchoAPI.DateTime { __data["createdAt"] }
          public var description: String? { __data["description"] }
          public var userSubreddit: UserSubreddit { __data["userSubreddit"] }
          public var overview: Overview? { __data["overview"] }

          public struct Fragments: FragmentContainer {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public var userFragment: UserFragment { _toFragment() }
          }

          public typealias UserSubreddit = UserFragment.UserSubreddit

          public typealias Overview = UserFragment.Overview
        }
      }
    }
  }

}