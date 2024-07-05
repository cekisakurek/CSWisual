//
//  ChartModule.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 26.06.24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct ChartsModule {

    // MARK: - State
    @ObservableState
    enum State: Equatable, Identifiable {
        case probability(ProbabilityChartModule.State)
        case distrubution(DistributionChartModule.State)
        case heatmap(HeatmapChartModule.State)

        var id: String {
            switch self {
            case .probability(let state):
                return state.id.uuidString
            case .distrubution(let state):
                return state.id.uuidString
            case .heatmap(let state):
                return state.id.uuidString
            }
        }

        var columnName: String {
            switch self {
            case .probability(let state):
                return state.data.name
            case .distrubution(let state):
                return state.data.name
            case .heatmap:
                return "heatmap"
            }
        }
    }

    // MARK: - Actions
    enum Action {
        case probability(ProbabilityChartModule.Action)
        case distrubution(DistributionChartModule.Action)
        case heatmap(HeatmapChartModule.Action)
    }

    // MARK: - Dependencies

    // MARK: - Body
    var body: some ReducerOf<Self> {
        Scope(state: \.probability, action: \.probability) {
            ProbabilityChartModule()
        }
        Scope(state: \.distrubution, action: \.distrubution) {
            DistributionChartModule()
        }
        Scope(state: \.heatmap, action: \.heatmap) {
            HeatmapChartModule()
        }
    }
}
