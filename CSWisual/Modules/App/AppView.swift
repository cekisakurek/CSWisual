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
                Button(
                    action: { store.send(.showDocumentPicker) },
                    label: { Text("Open") }
                )
            }
        )
        .sheet(
            isPresented: $store.showDocumentPicker,
            content: { DocumentPicker() }
        )
        .task {
            store.send(.appDidLaunched)
        }
    }
}

#Preview {
    AppView(store: Store(initialState: AppModule.State(), reducer: { AppModule() }))
}
