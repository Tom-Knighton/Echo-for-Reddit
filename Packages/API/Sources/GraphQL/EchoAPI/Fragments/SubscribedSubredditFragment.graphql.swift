// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension EchoAPI {
  struct SubscribedSubredditFragment: EchoAPI.SelectionSet, Fragment {
    public static var fragmentDefinition: StaticString {
      #"fragment SubscribedSubredditFragment on SubredditDto { __typename subredditId subredditTitle subredditIconUrl subredditName }"#
    }

    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { EchoAPI.Objects.SubredditDto }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("subredditId", String.self),
      .field("subredditTitle", String.self),
      .field("subredditIconUrl", String?.self),
      .field("subredditName", String.self),
    ] }

    public var subredditId: String { __data["subredditId"] }
    public var subredditTitle: String { __data["subredditTitle"] }
    public var subredditIconUrl: String? { __data["subredditIconUrl"] }
    public var subredditName: String { __data["subredditName"] }
  }

}