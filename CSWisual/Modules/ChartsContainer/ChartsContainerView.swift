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
                    Text("\($0.name) \(String($0.isNumber)) (\($0.type.rawValue))")
                        .selectionDisabled(!$0.isNumber)
                }
                .navigationTitle("Columns")
                .toolbar {
                    EditButton()
                }
            },
            detail: {
                GeometryReader { geometry in
                    ScrollView {
                        VStack {
                            ForEach(store.scope(state: \.charts, action: \.chartActions)) { rowStore in
                                GroupBox(rowStore.columnName) {
                                    ChartDrawView(store: rowStore)
                                        .frame(
                                            minHeight: geometry.size.height / 2.0,
                                            maxHeight: geometry.size.height - (geometry.safeAreaInsets.top + geometry.safeAreaInsets.top)
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

//#Preview {
//    GraphView()
//}
