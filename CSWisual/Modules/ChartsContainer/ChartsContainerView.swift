//
//  GraphView.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 26.06.24.
//

import SwiftUI
import ComposableArchitecture

struct ChartsContainerView: View {

    @Bindable var store: StoreOf<ChartsContainerModule>

    var body: some View {
        NavigationSplitView(
            sidebar: {
                List(store.columns, id: \.name, selection: $store.selectedHeaders) {
                    Text("\($0.name) (\($0.type.rawValue.capitalized))")
                        .selectionDisabled(!$0.isNumber)
                        .foregroundColor($0.isNumber ? .black : .gray)
                }
                .navigationTitle("Columns")
                .toolbar {
                    EditButton()
                }
            },
            detail: {
                GeometryReader { geo in
                    let spacing = (geo.safeAreaInsets.top + geo.safeAreaInsets.top)
                    ScrollView {
                        VStack {
                            ForEach(store.scope(state: \.charts, action: \.chartActions)) { rowStore in
                                GroupBox(rowStore.columnName) {
                                    ChartDrawView(store: rowStore)
                                        .frame(
                                            minHeight: geo.size.height / 2.0,
                                            maxHeight: geo.size.height - spacing
                                        )
                                }
                                .padding()
                            }
                        }
                    }
                }
                .toolbar {
                    ToolbarItemGroup(placement: .principal) {
                        Picker("", selection: $store.chartType) {
                            ForEach(ChartType.allCases) {
                                Text($0.rawValue)
                                    .tag($0)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                }
            }
        )
    }
}

#Preview {
    ChartsContainerView(
        store: Store(
            initialState: ChartsContainerModule.State(
                columns: []
            ),
            reducer: { ChartsContainerModule() }
        )
    )
}
