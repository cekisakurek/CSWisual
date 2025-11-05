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

    @ViewBuilder
    func printableChart(probabilities: ChartData, normal: ChartData) -> some View {
        VStack {
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
            .chartXAxis {
                AxisMarks(
                    preset: .aligned,
                    position: .bottom,
                    stroke: StrokeStyle(
                        lineWidth: 4,
                        lineCap: .butt,
                        lineJoin: .bevel,
                        miterLimit: 1,
                        dash: [],
                        dashPhase: 1
                    )
                )
            }
            .frame(width: 3508, height: 2480)
        }
        .frame(maxWidth: .infinity)
    }
    
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
                HStack {
                    Spacer()
                    Button(
                        action: {
                            let renderer = ImageRenderer(content: printableChart(probabilities: probabilities, normal: normal))
                            if let image = renderer.uiImage {
                                store.send(.print(image))
                            }
                        },
                        label: {
                            Image(systemName: "printer")
                        }
                    )
                    .padding(8)
                    
                }
                .padding(.top, 8)
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
