//
//  StatsChartView.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 15.07.24.
//

import SwiftUI
import Charts
import ComposableArchitecture

struct StatsChartView: View {

    let store: StoreOf<StatsChartModule>

    var body: some View {
        VStack {
            if let result = store.result {
                Text("Coefficient of variation: \(result.coefficientOfVariationString)")
                Text("Kurtosis A: \(result.kurtosisAString)")
                Text("Kurtosis B: \(result.kurtosisBString)")
                Text("Max: \(result.maxString)")
                Text("Median: \(result.medianString)")
                Text("Min: \(result.minString)")
                Text("Skewness A: \(result.skewnessAString)")
                Text("Skewness B: \(result.skewnessBString)")
                Text("Standard deviation : \(result.stdString)")
                Text("Standard deviation : \(result.stdString)")
                Text("Standard error of the mean: \(result.stdErrorOfMeanString)")
                Text("Variance: \(result.varianceString)")
                
            }

        }
    }
}

#Preview {
    StatsChartView(
        store: Store(
            initialState: StatsChartModule.State(
                data: .init(
                    name: "test",
                    data: []
                )
            ),
            reducer: { StatsChartModule() }
        )
    )
}
