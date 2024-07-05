//
//  DocumentModule.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 25.06.24.
//

import ComposableArchitecture
import Foundation
import CSV

@Reducer
struct DocumentModule {
    
    @ObservableState
    struct State: Equatable {
        let data: CSVData
        var chartContainerState: ChartsContainerModule.State
        init(data: CSVData) {
            self.data = data
            self.chartContainerState = ChartsContainerModule.State(columns: data.columns)
        }
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)

        // Child module actions
        case chartContainerAction(ChartsContainerModule.Action)
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .chartContainerAction(_):
                return .none
            case .binding(_):
                return .none
            }
        }
        Scope(state: \.chartContainerState, action: \.chartContainerAction) {
            ChartsContainerModule()
        }
    }
}
