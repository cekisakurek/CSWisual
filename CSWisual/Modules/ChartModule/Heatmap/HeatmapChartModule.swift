//
//  HeatmapChartModule.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 26.06.24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct HeatmapChartModule {

    // MARK: - State
    @ObservableState
    struct State: Equatable, Identifiable {
        let columns: [CSVData.Column]
        let headers: [String]
        var heatmap: HeatmapChartResult?

        let id = UUID()

        init(columns: [CSVData.Column]) {
            self.columns = columns
            self.headers = columns.map({ $0.name })

        }
    }

    // MARK: - Actions
    enum Action {
        case calculate
        case calculationComplete(Result<HeatmapChartResult, Error>)
    }

    // MARK: - Dependencies
    @Dependency(\.calculator.heatmapResult) var calculate

    // MARK: - Body
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .calculate:
                return .run { [columns = state.columns] send in
                    await send(
                        .calculationComplete(
                            Result {
                                try await calculate(columns)
                            }
                        )
                    )
                }
            case .calculationComplete(.success(let result)):
                state.heatmap = result
                return .none
            case .calculationComplete(.failure(let error)):
                // TODO: Show alert
                print(error)
                state.heatmap = nil
                return .none
            }
        }
    }
}
