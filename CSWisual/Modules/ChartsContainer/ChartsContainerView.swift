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
                        .foregroundColor($0.isNumber ? titleColor : disabledTitleColor)
                }
                .environment(\.editMode, .constant(.active))
                .navigationTitle("Columns")
            },
            detail: {
                GeometryReader { geo in
                    let spacing = (geo.safeAreaInsets.top + geo.safeAreaInsets.top)
                    ScrollView {
                        VStack {
                            Picker("", selection: $store.chartType) {
                                ForEach(ChartType.allCases) {
                                    Text($0.rawValue)
                                        .tag($0)
                                }
                            }
                            .padding(8)
                            .pickerStyle(.segmented)
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
            }
        )
    }
    
    var titleColor: Color {
        Color(UIColor(named: "TableTitleColor")!)
    }
    
    var disabledTitleColor: Color {
        Color(UIColor(named: "TableTitleColorDisabled")!)
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
