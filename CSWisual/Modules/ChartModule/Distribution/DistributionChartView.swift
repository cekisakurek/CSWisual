//
//  DistributionChartView.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 26.06.24.
//

import SwiftUI
import Charts
import ComposableArchitecture

struct DistributionChartView: View {
    @Bindable var store: StoreOf<DistributionChartModule>
    var body: some View {
        VStack {
            if let histogram = store.histogram, let frequencies = store.frequencies, let normal = store.normal {
                Chart {
                    ForEach(histogram.entries) {
                        BarMark(
                            x: .value("x", $0.x),
                            y: .value("y", $0.y / histogram.maxY),
                            width: MarkDimension(floatLiteral: 20)
                        )
                        .foregroundStyle(by: .value("Frequency", histogram.name))
                    }
                    ForEach(frequencies.entries) {
                        LineMark(
                            x: .value("FreqX", $0.x),
                            y: .value("FreqY", $0.y / frequencies.maxY),
                            series: .value("", "Frequency")
                        )
                        
                        .foregroundStyle(by: .value("Frequency", frequencies.name))
                        .interpolationMethod(.catmullRom)
                    }
                    ForEach(normal.entries) {
                        LineMark(
                            x: .value("NormX", $0.x),
                            y: .value("NormY", $0.y / normal.maxY),
                            series: .value("", "Normal")
                        )
                        .foregroundStyle(by: .value("Normal", normal.name))
                        .interpolationMethod(.catmullRom)
                    }
                }
                .chartForegroundStyleScale(range: [
                    Color.blue,
                    Color.red,
                    Color.brown
                ])
                .chartXScale(domain: (store.minXScale)...(store.maxXScale))
                .chartYAxis {
                    let frequencyStride = frequencies.yAxisValues
                    let histStride = histogram.yAxisValues
                    AxisMarks(position: .leading, values: frequencies.defaultAxisValues) { axis in
                        let value = frequencyStride[axis.index]
                        AxisValueLabel("\(String(format: "%.5F", value))", centered: false)
                    }
                    AxisMarks(position: .trailing, values: histogram.defaultAxisValues) { axis in
                        let value = histStride[axis.index]
                        AxisValueLabel("\(String(format: "%.0F", value))", centered: false)
                    }
                }
            } else {
                ProgressView()
            }
        }
        .task {
            store.send(.calculate)
        }
    }
}

//#Preview {
//    DistributionChartView()
//}
