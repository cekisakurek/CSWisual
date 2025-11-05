//
//  StatsChartModule.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 15.07.24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct StatsChartModule {

    // MARK: - State
    @ObservableState
    struct State: Equatable, Identifiable, Codable, Hashable {
        let data: CSVData.Column
        let id: UUID
        var result: StatsChartResult?

        init(data: CSVData.Column, id: UUID = UUID()) {
            self.id = id
            self.data = data
        }

    }

    // MARK: - Actions
    enum Action {
        case calculate
        case calculationComplete(Result<StatsChartResult, Error>)
    }

    // MARK: - Dependencies
    @Dependency(\.calculator.statsResult) var calculate

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
                state.result = result
                return .none
            case .calculationComplete(.failure(let error)):
                // TODO: Show alert
                print(error)
                state.result = nil
                return .none
            }
        }
    }
}
