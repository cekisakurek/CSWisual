//
//  ProbabilityChartView.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 26.06.24.
//

import SwiftUI
import Charts
import ComposableArchitecture

struct ProbabilityChartView: View {

    let store: StoreOf<ProbabilityChartModule>

    var body: some View {
        VStack {
            if let probabilities = store.probabilities, let normal = store.normal {
                Chart {
                    ForEach(probabilities.entries) {
                        PointMark(
                            x: .value("x", $0.xValue),
                            y: .value("y", $0.yValue)
                        )
                    }
                    ForEach(normal.entries) {
                        LineMark(
                            x: .value("x", $0.xValue),
                            y: .value("y", $0.yValue)
                        )
                        .foregroundStyle(Color.red)
                    }
                }
            } else {
                ProgressView()
            }
        }
    }
}

#Preview {
    ProbabilityChartView(
        store: Store(
            initialState: ProbabilityChartModule.State(
                data: .init(
                    name: "test",
                    data: []
                )
            ),
            reducer: { ProbabilityChartModule() }
        )
    )
}
