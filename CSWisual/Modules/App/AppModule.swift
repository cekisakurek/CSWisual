//
//  AppModule.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 25.06.24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct AppModule {
    
    @ObservableState
    struct State: Equatable {
        var showDocumentPicker: Bool = false
        var documentState: DocumentModule.State?
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case appDidLaunched
        case showDocumentPicker
        case openFile(URL)
        case fileOpenResult(Result<CSVData, Error>)
        
        // Child module actions
        case documentAction(DocumentModule.Action)
    }
    
    @Dependency(\.fileReader.readFromURL) var readFile
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .appDidLaunched:
                // TODO: Remove this
                let url = Bundle.main.url(forResource: "RealEstateTest", withExtension: "csv")!
//                let url = Bundle.main.url(forResource: "BitcoinTest", withExtension: "csv")!
                return .send(.openFile(url))
            case .showDocumentPicker:
                state.showDocumentPicker = true
                return .none
            case .openFile(let url):
                return .run { send in
                    await send(
                        .fileOpenResult(
                            Result {
                                try await readFile(url, UnicodeScalar(","))
                            }
                        )
                    )
                }
            case .documentAction(_):
                return .none
            case .fileOpenResult(.success(let data)):
                state.documentState = DocumentModule.State(data: data)
                return .none
            case .fileOpenResult(.failure(let error)):
                print(error)
                return .none
            case .binding(_):
                return .none
            }
        }
        .ifLet(\.documentState, action: \.documentAction) {
            DocumentModule()
        }
    }
}
