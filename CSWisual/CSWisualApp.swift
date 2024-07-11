//
//  CSWisualApp.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 25.06.24.
//

import SwiftUI
import ComposableArchitecture
@main
struct CSWisualApp: App {

    var body: some Scene {
        WindowGroup(
            content: {
                AppView(
                    store: Store(
                        initialState: $0.wrappedValue,
                        reducer: { AppModule() }
                    )
                )
            },
            defaultValue: { AppModule.State() })
    }
}
