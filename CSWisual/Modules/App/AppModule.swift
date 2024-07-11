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

    // MARK: - State
    @ObservableState
    struct State: Equatable, Identifiable, Codable, Hashable {
        var showDocumentPicker: Bool = false
        var readingFile: Bool = false
        var documentState: DocumentModule.State?
        let id: UUID
        var openFileURL: URL?

        var title: String = "CSWisual"
        init(
            showDocumentPicker: Bool = false,
            readingFile: Bool = false,
            documentState: DocumentModule.State? = nil,
            id: UUID = UUID(),
            openFileURL: URL? = nil
        ) {
            self.showDocumentPicker = showDocumentPicker
            self.readingFile = readingFile
            self.documentState = documentState
            self.id = id
            self.openFileURL = openFileURL
        }
    }

    // MARK: - Actions
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case appDidLaunched
        case showDocumentPicker
        case openFile(Result<URL, Error>)
        case fileOpenResult(Result<CSVData, Error>)

        // Child module actions
        case documentAction(DocumentModule.Action)
    }

    // MARK: - Dependencies
    @Dependency(\.fileReader.readFromURL) var readFile

    // MARK: - Body
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .appDidLaunched:
                return .run { [fileURL = state.openFileURL] send in
                    if let fileURL {
                        await send(.openFile(.success(fileURL)))
                    }
                }
            case .showDocumentPicker:
                state.showDocumentPicker = true
                return .none
            case .openFile(.success(let url)):
                state.readingFile = true
                return .run { send in
                    await send(
                        .fileOpenResult(
                            Result {
                                // TODO: Add support for other delimeters
                                try await readFile(url, UnicodeScalar(","))
                            }
                        )
                    )
                }
            case .openFile(.failure(let error)):
                state.readingFile = false
                print(error)
                return .none
            case .documentAction:
                return .none
            case .fileOpenResult(.success(let data)):
                state.title = data.url.lastPathComponent
                print(state.title)
                state.readingFile = false
                state.documentState = DocumentModule.State(data: data)
                return .none
            case .fileOpenResult(.failure(let error)):
                state.readingFile = false
                print(error)
                return .none
            case .binding:
                return .none
            }
        }
        .ifLet(\.documentState, action: \.documentAction) {
            DocumentModule()
        }
    }
}
