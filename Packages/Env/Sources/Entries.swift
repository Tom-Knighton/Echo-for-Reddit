//
//  Entries.swift
//  Env
//
//  Created by Tom Knighton on 27/01/2025.
//

import SwiftUI

public extension EnvironmentValues {
    @Entry var theme: Theme = EchoLightTheme()    
    @Entry var linkManager: LPMetadataManager = LPMetadataManager()
    
    @Entry var postNavNamespace: Namespace.ID = Namespace().wrappedValue
}
