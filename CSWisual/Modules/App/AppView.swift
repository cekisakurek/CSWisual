//
//  ContentView.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 25.06.24.
//

import SwiftUI
import ComposableArchitecture
import UniformTypeIdentifiers

struct AppView: View {

    @Bindable var store: StoreOf<AppModule>

    var body: some View {
        IfLetStore(
            store.scope(state: \.documentState, action: \.documentAction ),
            then: { DocumentView(store: $0) },
            else: {
                if store.readingFile {
                    ProgressView()
                } else {
                    Button(
                        action: { store.send(.showDocumentPicker) },
                        label: { Text("Open") }
                    )
                }
            }
        )
        .fileImporter(
            isPresented: $store.showDocumentPicker,
            allowedContentTypes: [UTType.commaSeparatedText],
            onCompletion: { store.send(.openFile($0)) })
        .task {
            store.send(.appDidLaunched)
        }
        .navigationTitle($store.title)
    }
}

#Preview {
    AppView(store: Store(initialState: AppModule.State(), reducer: { AppModule() }))
}
