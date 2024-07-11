//
//  ProbabilityChartModule.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 26.06.24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct ProbabilityChartModule {

    // MARK: - State
    @ObservableState
    struct State: Equatable, Identifiable, Codable, Hashable {
        let data: CSVData.Column
        var probabilities: ChartData?
        var normal: ChartData?
        let id: UUID

        init(data: CSVData.Column, id: UUID = UUID()) {
            self.id = id
            self.data = data
        }

    }

    // MARK: - Actions
    enum Action {
        case calculate
        case calculationComplete(Result<ProbabilityChartResult, Error>)
    }

    // MARK: - Dependencies
    @Dependency(\.calculator.probabilityResult) var calculate

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
                state.probabilities = result.data
                state.normal = result.normal
                return .none
            case .calculationComplete(.failure(let error)):
                // TODO: Show alert
                print(error)
                state.probabilities = nil
                state.normal = nil
                return .none
            }
        }
    }
}
