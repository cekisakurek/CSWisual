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

    @Environment(\.openWindow) private var openWindow

    var body: some Scene {
        WindowGroup(
            content: {
                AppView(
                    store: Store(
                        initialState: $0.wrappedValue,
                        reducer: { AppModule() }
                    )
                )
                .onOpenURL {
                    openWindow(value: AppModule.State(fileURL: $0))
                }
            },
            defaultValue: { AppModule.State() })
    }
}
