// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension EchoAPI {
  struct SubredditFragment: EchoAPI.SelectionSet, Fragment {
    public static var fragmentDefinition: StaticString {
      #"fragment SubredditFragment on SubredditDto { __typename subredditId subredditName subredditTitle subredditIconUrl userIsBanned subredditSubscriberCount subredditIsNSFW subredditTagline subredditDescription userIsSubscribed bannerImageUrl }"#
    }

    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { EchoAPI.Objects.SubredditDto }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("subredditId", String.self),
      .field("subredditName", String.self),
      .field("subredditTitle", String.self),
      .field("subredditIconUrl", String?.self),
      .field("userIsBanned", Bool.self),
      .field("subredditSubscriberCount", Int.self),
      .field("subredditIsNSFW", Bool.self),
      .field("subredditTagline", String.self),
      .field("subredditDescription", String.self),
      .field("userIsSubscribed", Bool.self),
      .field("bannerImageUrl", String?.self),
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
  }

}