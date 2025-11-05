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

    var collectionViewBackgroundColor: UIColor {
        UIColor(named: "RawCollectionViewBackgroundColor")!
    }
    
    var collectionViewHeaderColor: UIColor {
        UIColor(named: "RawCollectionViewHeaderColor")!
    }
    
    var collectionViewCellBackgroundColor: UIColor {
        UIColor(named: "RawCollectionViewCellBackgroundColor")!
    }
    
    var collectionViewCellLabelColor: UIColor {
        UIColor(named: "RawCollectionViewCellLabelColor")!
    }

    var collectionViewCellBorderColor: UIColor {
        UIColor(named: "RawCollectionViewCellBorderColor")!
    }
    
    
    var body: some View {
        TabView {
            RawAnalysisCollectionView(
                rows: store.data.raw,
                headers: store.data.headers,
                backgroundColor: collectionViewBackgroundColor,
                cellBackgroundColor: collectionViewCellBackgroundColor,
                cellLabelColor: collectionViewCellLabelColor,
                cellBorderColor: collectionViewCellBorderColor,
                headerColor: collectionViewHeaderColor
            )
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

#Preview {
    DocumentView(
        store: Store(
            initialState: DocumentModule.State(
                data: .init(
                    raw: [],
                    headers: [],
                    columns: [],
                    url: Bundle.main.url(forResource: "BitcoinTest", withExtension: "csv")!)
            ),
            reducer: { DocumentModule() }
        )
    )
}
