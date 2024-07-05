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
        WindowGroup {
            AppView(
                store: Store(
                    initialState: AppModule.State(),
                    reducer: { AppModule() }
                )
            )
        }
    }
}
