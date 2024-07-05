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
    @ObservableState
    struct State: Equatable {
        let data: CSVData.Column
        var probabilities: ChartData?
        var normal: ChartData?
 
        init(data: CSVData.Column) {
            self.data = data
        }
        
        let id = UUID()
    }
    
    enum Action{
        case calculate
        case calculationComplete(Result<ProbabilityChartResult, Error>)
    }
    
    @Dependency(\.calculator.probabilityResult) var calculate

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
                print("Calculation complete for \(state.data.name)")
                state.probabilities = result.data
                state.normal = result.normal
       
                return .none
            case .calculationComplete(.failure(let error)):
                print(error)
                state.probabilities = nil
                state.normal = nil
                return .none
            }
        }
    }
}
