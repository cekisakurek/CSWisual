//
//  DistributionChartModule.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 26.06.24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct DistributionChartModule {

    // MARK: - State
    @ObservableState
    struct State: Equatable, Identifiable {
        let data: CSVData.Column

        var histogram: ChartData?
        var frequencies: ChartData?
        var normal: ChartData?
        // TODO: make width variable
        var width: Double = 10

        let id = UUID()

        var minXScale: Double {
            return min(normal?.minX ?? 0.0, frequencies?.minX ?? 0.0)
        }

        var maxXScale: Double {
            return max(normal?.maxX ?? 0.0, frequencies?.maxX ?? 0.0)
        }

        init(data: CSVData.Column) {
            self.data = data
        }
    }

    // MARK: - Actions
    enum Action {
        case calculate
        case calculationComplete(Result<DistributionChartResult, Error>)

    }

    // MARK: - Dependencies
    @Dependency(\.calculator.distributionResult) var calculate

    // MARK: - Body
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .calculate:
                return .run { [csv = state.data] send in
                    await send(
                        .calculationComplete(
                            Result {
                                try await calculate(csv)
                            }
                        )
                    )
                }
            case .calculationComplete(.success(let result)):
                state.histogram = result.histogram
                state.frequencies = result.frequency
                state.normal = result.normal
                return .none
            case .calculationComplete(.failure(let error)):
                // TODO: Show alert
                print(error)
                state.histogram = nil
                state.frequencies = nil
                state.normal = nil
                return .none
            }
        }
    }
}
