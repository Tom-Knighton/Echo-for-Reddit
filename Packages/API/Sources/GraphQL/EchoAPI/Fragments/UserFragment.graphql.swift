// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension EchoAPI {
  struct UserFragment: EchoAPI.SelectionSet, Fragment {
    public static var fragmentDefinition: StaticString {
      #"fragment UserFragment on UserDto { __typename id name iconImageUrl totalKarma postKarma commentKarma createdAt description userSubreddit { __typename subredditTitle subredditIsNSFW bannerImageUrl } overview(first: 25, sort: NEW) { __typename edges { __typename node { __typename ... on PostComment { commentId commentText commentScore commentCreatedAt voteStatus commentFlagDetails { __typename isNSFW isSaved isLocked isArchived isArchived isSpoiler distinguishmentType } } ... on PostDto { postId postTitle postCreatedAt postCommentCount } } } } }"#
    }

    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { EchoAPI.Objects.UserDto }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("id", String.self),
      .field("name", String.self),
      .field("iconImageUrl", String.self),
      .field("totalKarma", Int.self),
      .field("postKarma", Int.self),
      .field("commentKarma", Int.self),
      .field("createdAt", EchoAPI.DateTime.self),
      .field("description", String?.self),
      .field("userSubreddit", UserSubreddit.self),
      .field("overview", Overview?.self, arguments: [
        "first": 25,
        "sort": "NEW"
      ]),
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

    /// UserSubreddit
    ///
    /// Parent Type: `SubredditDto`
    public struct UserSubreddit: EchoAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { EchoAPI.Objects.SubredditDto }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("subredditTitle", String.self),
        .field("subredditIsNSFW", Bool.self),
        .field("bannerImageUrl", String?.self),
      ] }

      public var subredditTitle: String { __data["subredditTitle"] }
      public var subredditIsNSFW: Bool { __data["subredditIsNSFW"] }
      public var bannerImageUrl: String? { __data["bannerImageUrl"] }
    }

    /// Overview
    ///
    /// Parent Type: `OverviewConnection`
    public struct Overview: EchoAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { EchoAPI.Objects.OverviewConnection }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("edges", [Edge]?.self),
      ] }

      /// A list of edges.
      public var edges: [Edge]? { __data["edges"] }

      /// Overview.Edge
      ///
      /// Parent Type: `OverviewEdge`
      public struct Edge: EchoAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { EchoAPI.Objects.OverviewEdge }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("node", Node.self),
        ] }

        /// The item at the end of the edge.
        public var node: Node { __data["node"] }

        /// Overview.Edge.Node
        ///
        /// Parent Type: `RedditThing`
        public struct Node: EchoAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { EchoAPI.Unions.RedditThing }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .inlineFragment(AsPostComment.self),
            .inlineFragment(AsPostDto.self),
          ] }

          public var asPostComment: AsPostComment? { _asInlineFragment() }
          public var asPostDto: AsPostDto? { _asInlineFragment() }

          /// Overview.Edge.Node.AsPostComment
          ///
          /// Parent Type: `PostComment`
          public struct AsPostComment: EchoAPI.InlineFragment {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public typealias RootEntityType = UserFragment.Overview.Edge.Node
            public static var __parentType: any ApolloAPI.ParentType { EchoAPI.Objects.PostComment }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("commentId", String.self),
              .field("commentText", String.self),
              .field("commentScore", Int?.self),
              .field("commentCreatedAt", EchoAPI.DateTime.self),
              .field("voteStatus", GraphQLEnum<EchoAPI.VoteStatus>.self),
              .field("commentFlagDetails", CommentFlagDetails.self),
            ] }

            public var commentId: String { __data["commentId"] }
            public var commentText: String { __data["commentText"] }
            public var commentScore: Int? { __data["commentScore"] }
            public var commentCreatedAt: EchoAPI.DateTime { __data["commentCreatedAt"] }
            public var voteStatus: GraphQLEnum<EchoAPI.VoteStatus> { __data["voteStatus"] }
            public var commentFlagDetails: CommentFlagDetails { __data["commentFlagDetails"] }

            /// Overview.Edge.Node.AsPostComment.CommentFlagDetails
            ///
            /// Parent Type: `PostFlagDetails`
            public struct CommentFlagDetails: EchoAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: any ApolloAPI.ParentType { EchoAPI.Objects.PostFlagDetails }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("isNSFW", Bool.self),
                .field("isSaved", Bool.self),
                .field("isLocked", Bool.self),
                .field("isArchived", Bool.self),
                .field("isSpoiler", Bool.self),
                .field("distinguishmentType", GraphQLEnum<EchoAPI.DistinguishmentType>.self),
              ] }

              public var isNSFW: Bool { __data["isNSFW"] }
              public var isSaved: Bool { __data["isSaved"] }
              public var isLocked: Bool { __data["isLocked"] }
              public var isArchived: Bool { __data["isArchived"] }
              public var isSpoiler: Bool { __data["isSpoiler"] }
              public var distinguishmentType: GraphQLEnum<EchoAPI.DistinguishmentType> { __data["distinguishmentType"] }
            }
          }

          /// Overview.Edge.Node.AsPostDto
          ///
          /// Parent Type: `PostDto`
          public struct AsPostDto: EchoAPI.InlineFragment {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public typealias RootEntityType = UserFragment.Overview.Edge.Node
            public static var __parentType: any ApolloAPI.ParentType { EchoAPI.Objects.PostDto }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("postId", String.self),
              .field("postTitle", String.self),
              .field("postCreatedAt", EchoAPI.DateTime.self),
              .field("postCommentCount", Int.self),
            ] }

            public var postId: String { __data["postId"] }
            public var postTitle: String { __data["postTitle"] }
            public var postCreatedAt: EchoAPI.DateTime { __data["postCreatedAt"] }
            public var postCommentCount: Int { __data["postCommentCount"] }
          }
        }
      }
    }
  }

}