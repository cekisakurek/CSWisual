//
//  HeatmapChartView.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 26.06.24.
//

import SwiftUI
import Charts
import ComposableArchitecture

struct HeatmapChartView: View {
    @Bindable var store: StoreOf<HeatmapChartModule>
    let gradientColors: [Color] = [.blue, .green, .yellow, .orange, .red]
    var body: some View {
        VStack {
            if let heatmap = store.heatmap {
                Chart {
                    ForEach(heatmap.data) {
                        let xVal = Int($0.x)
                        let yVal = Int($0.y)
                        RectangleMark(
                            xStart: PlottableValue.value("xStart", xVal),
                            xEnd: PlottableValue.value("xEnd", xVal + 1),
                            yStart: PlottableValue.value("yStart", yVal),
                            yEnd: PlottableValue.value("yEnd", yVal + 1)
                        )
                        .foregroundStyle(by: .value("Number", $0.value))
                    }
                }
                .chartYAxis {
                    AxisMarks(position: .leading, values: Array(stride(from: 0, through: heatmap.labels.count - 1, by: 1))) {
                        AxisGridLine()
                        AxisTick()
                        let name = heatmap.labels[$0.index]
                        AxisValueLabel{
                            Text(name)
                        }
                    }
                }
                .chartXAxis {
                    AxisMarks(values: Array(stride(from: 0, through: heatmap.labels.count - 1, by: 1))) {
                        AxisGridLine()
                        AxisTick()
                        let name = heatmap.labels[$0.index]
                        AxisValueLabel{
                            Text(name)
                                .rotate(.degrees(-90))
                        }
                    }
                }
                .chartForegroundStyleScale(range: Gradient(colors: gradientColors))
                .aspectRatio(1, contentMode: .fit)
            } else {
                ProgressView()
            }
            
        }
        .onAppear {
            store.send(.calculate)
        }
        
    }
}

//#Preview {
//    HeatmapChartView()
//}
