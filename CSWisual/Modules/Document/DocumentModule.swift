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

    // MARK: - State
    @ObservableState
    struct State: Equatable, Codable, Hashable {
        let data: CSVData
        var chartContainerState: ChartsContainerModule.State
        init(data: CSVData) {
            self.data = data
            self.chartContainerState = ChartsContainerModule.State(columns: data.columns)
        }
    }

    // MARK: - Actions
    enum Action: BindableAction {
        case binding(BindingAction<State>)

        // Child module actions
        case chartContainerAction(ChartsContainerModule.Action)
    }

    // MARK: - Dependencies

    // MARK: - Body
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { _, action in
            switch action {
            case .chartContainerAction:
                return .none
            case .binding:
                return .none
            }
        }
        Scope(state: \.chartContainerState, action: \.chartContainerAction) {
            ChartsContainerModule()
        }
    }
}
