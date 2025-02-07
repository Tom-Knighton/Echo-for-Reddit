// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension EchoAPI {
  struct SubredditPostFragment: EchoAPI.SelectionSet, Fragment {
    public static var fragmentDefinition: StaticString {
      #"fragment SubredditPostFragment on PostDto { __typename postId cursorId postAuthor postFlair postSubreddit postTitle postScore postCommentCount subredditIcon postCreatedAt postVoteStatus postFlagDetails { __typename isNSFW isSaved isStickied isSpoiler isArchived isLocked } postContent { __typename textContent contentType media { __typename url isInline thumbnailUrl width height hlsDashUrl type mediaText } } }"#
    }

    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { EchoAPI.Objects.PostDto }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("postId", String.self),
      .field("cursorId", String.self),
      .field("postAuthor", String.self),
      .field("postFlair", String?.self),
      .field("postSubreddit", String.self),
      .field("postTitle", String.self),
      .field("postScore", Int.self),
      .field("postCommentCount", Int.self),
      .field("subredditIcon", String?.self),
      .field("postCreatedAt", EchoAPI.DateTime.self),
      .field("postVoteStatus", GraphQLEnum<EchoAPI.VoteStatus>?.self),
      .field("postFlagDetails", PostFlagDetails.self),
      .field("postContent", PostContent.self),
    ] }

    public var postId: String { __data["postId"] }
    public var cursorId: String { __data["cursorId"] }
    public var postAuthor: String { __data["postAuthor"] }
    public var postFlair: String? { __data["postFlair"] }
    public var postSubreddit: String { __data["postSubreddit"] }
    public var postTitle: String { __data["postTitle"] }
    public var postScore: Int { __data["postScore"] }
    public var postCommentCount: Int { __data["postCommentCount"] }
    public var subredditIcon: String? { __data["subredditIcon"] }
    public var postCreatedAt: EchoAPI.DateTime { __data["postCreatedAt"] }
    public var postVoteStatus: GraphQLEnum<EchoAPI.VoteStatus>? { __data["postVoteStatus"] }
    public var postFlagDetails: PostFlagDetails { __data["postFlagDetails"] }
    public var postContent: PostContent { __data["postContent"] }

    /// PostFlagDetails
    ///
    /// Parent Type: `PostFlagDetails`
    public struct PostFlagDetails: EchoAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { EchoAPI.Objects.PostFlagDetails }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("isNSFW", Bool.self),
        .field("isSaved", Bool.self),
        .field("isStickied", Bool.self),
        .field("isSpoiler", Bool.self),
        .field("isArchived", Bool.self),
        .field("isLocked", Bool.self),
      ] }

      public var isNSFW: Bool { __data["isNSFW"] }
      public var isSaved: Bool { __data["isSaved"] }
      public var isStickied: Bool { __data["isStickied"] }
      public var isSpoiler: Bool { __data["isSpoiler"] }
      public var isArchived: Bool { __data["isArchived"] }
      public var isLocked: Bool { __data["isLocked"] }
    }

    /// PostContent
    ///
    /// Parent Type: `PostContent`
    public struct PostContent: EchoAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { EchoAPI.Objects.PostContent }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("textContent", String?.self),
        .field("contentType", GraphQLEnum<EchoAPI.PostContentType>.self),
        .field("media", [Medium].self),
      ] }

      public var textContent: String? { __data["textContent"] }
      public var contentType: GraphQLEnum<EchoAPI.PostContentType> { __data["contentType"] }
      public var media: [Medium] { __data["media"] }

      /// PostContent.Medium
      ///
      /// Parent Type: `PostMedia`
      public struct Medium: EchoAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { EchoAPI.Objects.PostMedia }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("url", String.self),
          .field("isInline", Bool.self),
          .field("thumbnailUrl", String?.self),
          .field("width", Double.self),
          .field("height", Double.self),
          .field("hlsDashUrl", String?.self),
          .field("type", GraphQLEnum<EchoAPI.PostContentType>?.self),
          .field("mediaText", String?.self),
        ] }

        public var url: String { __data["url"] }
        public var isInline: Bool { __data["isInline"] }
        public var thumbnailUrl: String? { __data["thumbnailUrl"] }
        public var width: Double { __data["width"] }
        public var height: Double { __data["height"] }
        public var hlsDashUrl: String? { __data["hlsDashUrl"] }
        public var type: GraphQLEnum<EchoAPI.PostContentType>? { __data["type"] }
        public var mediaText: String? { __data["mediaText"] }
      }
    }
  }

}