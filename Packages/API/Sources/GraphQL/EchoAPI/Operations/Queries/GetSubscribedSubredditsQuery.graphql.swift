// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension EchoAPI {
  class GetSubscribedSubredditsQuery: GraphQLQuery {
    static let operationName: String = "GetSubscribedSubreddits"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query GetSubscribedSubreddits { reddit { __typename subscribed { __typename subredditId } } }"#
      ))

    public init() {}

    struct Data: EchoAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: any ApolloAPI.ParentType { EchoAPI.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("reddit", Reddit.self),
      ] }

      var reddit: Reddit { __data["reddit"] }

      /// Reddit
      ///
      /// Parent Type: `RedditQuery`
      struct Reddit: EchoAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: any ApolloAPI.ParentType { EchoAPI.Objects.RedditQuery }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("subscribed", [Subscribed].self),
        ] }

        var subscribed: [Subscribed] { __data["subscribed"] }

        /// Reddit.Subscribed
        ///
        /// Parent Type: `SubredditDto`
        struct Subscribed: EchoAPI.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: any ApolloAPI.ParentType { EchoAPI.Objects.SubredditDto }
          static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("subredditId", String.self),
          ] }

          var subredditId: String { __data["subredditId"] }
        }
      }
    }
  }

}