//
//  ChartData.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 26.06.24.
//

import Foundation

struct ChartData: Identifiable, Equatable {

    let id = UUID()
    let name: String

    let minX: Double
    let maxX: Double

    let minY: Double
    let maxY: Double

    let entries: [Entry]

    let yAxisValues: [Double]
    let xAxisValues: [Double]

    let defaultAxisValues: [Double]

    init(name: String, entries: [Entry]) {
        self.entries = entries

        self.minX = entries.min(by: { $0.xValue < $1.xValue }).map({ $0.xValue }) ?? Double.greatestFiniteMagnitude
        self.maxX = entries.max { $0.xValue < $1.xValue }.map({ $0.xValue }) ?? 0.0

        self.minY = entries.min(by: { $0.yValue < $1.yValue }).map({ $0.yValue }) ?? Double.greatestFiniteMagnitude
        self.maxY = entries.max { $0.yValue < $1.yValue }.map({ $0.yValue }) ?? 0.0

        let strideBy = Double(entries.count) / 100.0

        self.xAxisValues = Array(stride(from: self.minX, through: self.maxX, by: (self.maxX - self.minX) / strideBy))
        self.yAxisValues = Array(stride(from: self.minY, through: self.maxY, by: (self.maxY - self.minY) / strideBy))

        self.defaultAxisValues = Array(stride(from: 0, to: 1, by: 1.0/strideBy))
        self.name = name
    }

    struct Entry: Identifiable, Equatable {
        let xValue: Double
        let yValue: Double
        var id: String { "\(xValue)-\(yValue)" }
    }
}
