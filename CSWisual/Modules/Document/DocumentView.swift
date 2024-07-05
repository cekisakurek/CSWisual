//
//  DocumentView.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 25.06.24.
//

import SwiftUI
import ComposableArchitecture

struct DocumentView: View {
    let store: StoreOf<DocumentModule>
    var body: some View {
        TabView {
            RawAnalysisCollectionView(rows: store.data.raw, headers: store.data.headers)
                .tabItem {
                    Label("Raw", systemImage: "tablecells.badge.ellipsis")
                }
            ChartsContainerView(store: store.scope(state: \.chartContainerState, action: \.chartContainerAction ))
                .tabItem {
                    Label("Charts", systemImage: "chart.line.uptrend.xyaxis")
                }
        }
    }
}
