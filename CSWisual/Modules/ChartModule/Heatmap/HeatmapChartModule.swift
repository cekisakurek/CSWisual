//
//  HeatmapChartModule.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 26.06.24.
//

import Foundation
import ComposableArchitecture
import SigmaSwiftStatistics



@Reducer
struct HeatmapChartModule {
    @ObservableState
    struct State: Equatable {
        let columns: [CSVData.Column]
        var heatmap: HeatmapChartResult?
        var headers: [String] {
            columns.map({ $0.name })
        }
        
        let id = UUID()
        
        init(columns: [CSVData.Column]) {
            self.columns = columns
            
        }
    }
    
    enum Action{
        case calculate
        case calculationComplete(Result<HeatmapChartResult, Error>)
    }

    @Dependency(\.calculator.heatmapResult) var calculate
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .calculate:
                return .run { [columns = state.columns, headers = state.headers] send in
                    await send(
                        .calculationComplete(
                            Result {
                                try await calculate(columns)
                            }
                        )
                    )
                }
            case .calculationComplete(.success(let result)):
//                print("Calculation complete for \(state.headers)")
                state.heatmap = result
                return .none
            case .calculationComplete(.failure(let error)):
                print(error)
                state.heatmap = nil
                return .none
            }
        }
    }
}
