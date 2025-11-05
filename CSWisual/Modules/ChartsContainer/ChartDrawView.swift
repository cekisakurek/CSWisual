//
//  ChartDrawView.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 27.06.24.
//

import SwiftUI
import ComposableArchitecture

struct ChartDrawView: View {

    let store: StoreOf<ChartsModule>

    var body: some View {
        switch store.state {
        case .probability:
            if let store = store.scope(state: \.probability, action: \.probability) {
                ProbabilityChartView(store: store)
                    .onAppear {
                        store.send(.calculate)
                    }
            }
        case .distrubution:
            if let store = store.scope(state: \.distrubution, action: \.distrubution) {
                DistributionChartView(store: store)
                    .onAppear {
                        store.send(.calculate)
                    }
            }
        case .heatmap:
            if let store = store.scope(state: \.heatmap, action: \.heatmap) {
                HeatmapChartView(store: store)
            }
        case .stats:
            if let store = store.scope(state: \.stats, action: \.stats) {
                StatsChartView(store: store)
                    .onAppear {
                        store.send(.calculate)
                    }
            }
        }
    }
}

#Preview {
    ChartDrawView(
        store: Store(
            initialState: ChartsModule.State.distrubution(
                .init(
                    data: .init(
                        name: "test",
                        data: []
                    )
                )
            ),
            reducer: { ChartsModule() }
        )
    )
}
