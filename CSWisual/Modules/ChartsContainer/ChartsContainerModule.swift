//
//  GraphModule.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 26.06.24.
//

import Foundation

import ComposableArchitecture
import Foundation
import CSV

enum ChartType: String, CaseIterable, Identifiable {
    case probability
    case distribution
    case heatmap
    
    var id: String { self.rawValue }
}


@Reducer
struct ChartsContainerModule {
    
    @ObservableState
    struct State: Equatable {
        let columns: [CSVData.Column]
        var selectedHeaders: Set<String>
        var chartType: ChartType = .probability
        var charts: IdentifiedArrayOf<ChartsModule.State> = []
    
        var headers: [String] {
            columns.map({ $0.name })
        }
        
        init(columns: [CSVData.Column]) {
            self.columns = columns
            self.selectedHeaders = []
        }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case update
        
        // Child module actions
        case chartActions(IdentifiedActionOf<ChartsModule>)
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(\.chartType):
                return .send(.update)
            case .binding(\.selectedHeaders):
                return .send(.update)
            case .binding(_):
                return .none
            case .chartActions(_):
                return .none
            case .update:
                switch state.chartType {
                case .probability:
                    state.charts = IdentifiedArray(
                        uniqueElements: state.selectedHeaders.map { name in
                                .probability(ProbabilityChartModule.State(data: state.columns.first(where: { $0.name == name })!))
                        }
                    )
                    return .none
                case .distribution:
                    state.charts = IdentifiedArray(
                        uniqueElements: state.selectedHeaders.map { name in
                            .distrubution(DistributionChartModule.State(data: state.columns.first(where: { $0.name == name })!))
                        }
                    )
                    return .none
                case .heatmap:
                    state.charts = IdentifiedArray(
                        uniqueElements: [
                            .heatmap(HeatmapChartModule.State(
                                columns: state.columns.filter({ state.selectedHeaders.contains($0.name) }))
                            )
                        ]
                    )
                    return .none
                }
            }
        }
        .forEach(\.charts, action: \.chartActions) {
            ChartsModule()
        }
    }
}