// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension EchoAPI {
  class GetSubredditPostsQuery: GraphQLQuery {
    public static let operationName: String = "GetSubredditPosts"
    public static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query GetSubredditPosts($after: String, $subredditName: String!, $sort: RedditSortOption!) { reddit { __typename subreddit(subredditName: $subredditName) { __typename posts(first: 25, after: $after, sort: $sort) { __typename edges { __typename node { __typename ...SubredditPostFragment parentPost { __typename ...SubredditPostFragment } } } } } } }"#,
        fragments: [SubredditPostFragment.self]
      ))

    public var after: GraphQLNullable<String>
    public var subredditName: String
    public var sort: GraphQLEnum<RedditSortOption>

    public init(
      after: GraphQLNullable<String>,
      subredditName: String,
      sort: GraphQLEnum<RedditSortOption>
    ) {
      self.after = after
      self.subredditName = subredditName
      self.sort = sort
    }

    public var __variables: Variables? { [
      "after": after,
      "subredditName": subredditName,
      "sort": sort
    ] }

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
          .field("subreddit", Subreddit.self, arguments: ["subredditName": .variable("subredditName")]),
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
            .field("posts", Posts?.self, arguments: [
              "first": 25,
              "after": .variable("after"),
              "sort": .variable("sort")
            ]),
          ] }

          public var posts: Posts? { __data["posts"] }

          /// Reddit.Subreddit.Posts
          ///
          /// Parent Type: `PostsConnection`
          public struct Posts: EchoAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: any ApolloAPI.ParentType { EchoAPI.Objects.PostsConnection }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("edges", [Edge]?.self),
            ] }

            /// A list of edges.
            public var edges: [Edge]? { __data["edges"] }

            /// Reddit.Subreddit.Posts.Edge
            ///
            /// Parent Type: `PostsEdge`
            public struct Edge: EchoAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: any ApolloAPI.ParentType { EchoAPI.Objects.PostsEdge }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("node", Node.self),
              ] }

              /// The item at the end of the edge.
              public var node: Node { __data["node"] }

              /// Reddit.Subreddit.Posts.Edge.Node
              ///
              /// Parent Type: `PostDto`
              public struct Node: EchoAPI.SelectionSet {
                public let __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public static var __parentType: any ApolloAPI.ParentType { EchoAPI.Objects.PostDto }
                public static var __selections: [ApolloAPI.Selection] { [
                  .field("__typename", String.self),
                  .field("parentPost", ParentPost?.self),
                  .fragment(SubredditPostFragment.self),
                ] }

                public var parentPost: ParentPost? { __data["parentPost"] }
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

                public struct Fragments: FragmentContainer {
                  public let __data: DataDict
                  public init(_dataDict: DataDict) { __data = _dataDict }

                  public var subredditPostFragment: SubredditPostFragment { _toFragment() }
                }

                /// Reddit.Subreddit.Posts.Edge.Node.ParentPost
                ///
                /// Parent Type: `PostDto`
                public struct ParentPost: EchoAPI.SelectionSet {
                  public let __data: DataDict
                  public init(_dataDict: DataDict) { __data = _dataDict }

                  public static var __parentType: any ApolloAPI.ParentType { EchoAPI.Objects.PostDto }
                  public static var __selections: [ApolloAPI.Selection] { [
                    .field("__typename", String.self),
                    .fragment(SubredditPostFragment.self),
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

                  public struct Fragments: FragmentContainer {
                    public let __data: DataDict
                    public init(_dataDict: DataDict) { __data = _dataDict }

                    public var subredditPostFragment: SubredditPostFragment { _toFragment() }
                  }

                  public typealias PostFlagDetails = SubredditPostFragment.PostFlagDetails

                  public typealias PostContent = SubredditPostFragment.PostContent
                }

                public typealias PostFlagDetails = SubredditPostFragment.PostFlagDetails

                public typealias PostContent = SubredditPostFragment.PostContent
              }
            }
          }
        }
      }
    }
  }

}