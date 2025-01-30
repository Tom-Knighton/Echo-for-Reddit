// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

protocol EchoAPI_SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == EchoAPI.SchemaMetadata {}

protocol EchoAPI_InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == EchoAPI.SchemaMetadata {}

protocol EchoAPI_MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == EchoAPI.SchemaMetadata {}

protocol EchoAPI_MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == EchoAPI.SchemaMetadata {}

extension EchoAPI {
  typealias SelectionSet = EchoAPI_SelectionSet

  typealias InlineFragment = EchoAPI_InlineFragment

  typealias MutableSelectionSet = EchoAPI_MutableSelectionSet

  typealias MutableInlineFragment = EchoAPI_MutableInlineFragment

  enum SchemaMetadata: ApolloAPI.SchemaMetadata {
    static let configuration: any ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

    static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
      switch typename {
      case "Query": return EchoAPI.Objects.Query
      case "RedditQuery": return EchoAPI.Objects.RedditQuery
      case "SubredditDto": return EchoAPI.Objects.SubredditDto
      default: return nil
      }
    }
  }

  enum Objects {}
  enum Interfaces {}
  enum Unions {}

}