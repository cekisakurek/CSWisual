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
    struct State: Equatable, Identifiable, Codable, Hashable {
        let columns: [CSVData.Column]
        let headers: [String]
        var heatmap: HeatmapChartResult?
        
        var errors: [String] = []

        let id: UUID

        init(columns: [CSVData.Column], id: UUID = UUID()) {
            self.id = id
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
                switch error {
                case CalculatorError.heatmapPleaseSelectMoreColumns:
                    state.errors.append("Please select more than one column!")
                default:
                    state.errors.append(error.localizedDescription)
                }
                state.heatmap = nil
                return .none
            }
        }
    }
}
