//
//  Calculator.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 27.06.24.
//
import Foundation
import ComposableArchitecture
import SigmaSwiftStatistics

struct Calculator {
    let probabilityResult: (CSVData.Column) async throws -> ProbabilityChartResult
    let distributionResult: (CSVData.Column) async throws -> DistributionChartResult
    let heatmapResult: ([CSVData.Column]) async throws -> HeatmapChartResult
}

extension Calculator: DependencyKey {
    static var liveValue = Self(
        probabilityResult: { csv in
            let data = csv.data

            let numbers = csv.asDouble()
            let distribution = numbers.probabilityDistribution()
            let (bValue, mValue) = leastSquaresRegression(distribution)

            let probabilityEntries = distribution.map(ChartData.Entry.init)

            let normalEntries = distribution.map({ xValue, _ in
                let yValue = (mValue * xValue) + bValue
                return ChartData.Entry(xValue: xValue, yValue: yValue)
            })
            return ProbabilityChartResult(
                data: .init(name: "Probability", entries: probabilityEntries),
                normal: .init(name: "Normal", entries: normalEntries)
            )
        },
        distributionResult: { csv in
            let data = csv.data
            let numbers = csv.asDouble()
            let distribution = numbers.probabilityDistribution()

            let frequencies = numbers.frequencies()

            let binEdges = numbers.binEdges()

            let histogramEntries = binEdges.map({ edge in
                let count = edge.values.reduce(0) { $0 + $1.value }
                return ChartData.Entry(
                    xValue: Double((edge.lowerValue + edge.upperValue) / 2.0),
                    yValue: Double(count)
                )
            })

            let frequencyEntries = frequencies
                .sorted(by: { $0.key < $1.key })
                .map(ChartData.Entry.init)

            let (bValue, mValue) = leastSquaresRegression(distribution)
            let normalFrequencyEntries = distribution
                .map({ xValue, _ in (mValue * xValue) + bValue })
                .frequencies()
                .sorted(by: { $0.key < $1.key })
                .map(ChartData.Entry.init)

            return DistributionChartResult(
                histogram: .init(name: "Histogram", entries: histogramEntries),
                frequency: .init(name: "Frequency", entries: frequencyEntries),
                normal: .init(name: "Normal Frequency", entries: normalFrequencyEntries)
            )
        },
        heatmapResult: { columns in

            let labels = columns.map({ $0.name })

            let matrixEntries = columns.enumerated().flatMap { columnIndex, column in
                columns.enumerated().map { rowIndex, row in
                    var correlation = 0.0
                    if columnIndex == rowIndex {
                        correlation = 1.0
                    } else if let pearson = Sigma.pearson(x: column.asDouble(), y: row.asDouble()) {
                        correlation = pearson
                    }
                    correlation = correlation.roundedUp(to: 4)
                    let label1 = labels[columnIndex]
                    let label2 = labels[rowIndex]
                    return MatrixEntry(
                        columnLabel: label1,
                        rowLabel: label2,
                        value: correlation,
                        xValue: Double(columnIndex),
                        yValue: Double(rowIndex)
                    )
                }
            }
            let result = HeatmapChartResult(
                data: matrixEntries,
                labels: labels
            )
            return result
        }
    )
}

extension DependencyValues {
    var calculator: Calculator {
        get { self[Calculator.self] }
        set { self[Calculator.self] = newValue }
    }
}
