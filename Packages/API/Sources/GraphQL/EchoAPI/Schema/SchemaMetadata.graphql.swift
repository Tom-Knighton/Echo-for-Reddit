// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public protocol EchoAPI_SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == EchoAPI.SchemaMetadata {}

public protocol EchoAPI_InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == EchoAPI.SchemaMetadata {}

public protocol EchoAPI_MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == EchoAPI.SchemaMetadata {}

public protocol EchoAPI_MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == EchoAPI.SchemaMetadata {}

public extension EchoAPI {
  typealias SelectionSet = EchoAPI_SelectionSet

  typealias InlineFragment = EchoAPI_InlineFragment

  typealias MutableSelectionSet = EchoAPI_MutableSelectionSet

  typealias MutableInlineFragment = EchoAPI_MutableInlineFragment

  enum SchemaMetadata: ApolloAPI.SchemaMetadata {
    public static let configuration: any ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

    public static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
      switch typename {
      case "OverviewConnection": return EchoAPI.Objects.OverviewConnection
      case "OverviewEdge": return EchoAPI.Objects.OverviewEdge
      case "PostComment": return EchoAPI.Objects.PostComment
      case "PostDto": return EchoAPI.Objects.PostDto
      case "PostFlagDetails": return EchoAPI.Objects.PostFlagDetails
      case "Query": return EchoAPI.Objects.Query
      case "RedditQuery": return EchoAPI.Objects.RedditQuery
      case "SubredditDto": return EchoAPI.Objects.SubredditDto
      case "UserDto": return EchoAPI.Objects.UserDto
      default: return nil
      }
    }
  }

  enum Objects {}
  enum Interfaces {}
  enum Unions {}

}