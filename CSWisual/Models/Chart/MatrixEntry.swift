//
//  MatrixEntry.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 05.07.24.
//

import Foundation

struct MatrixEntry: Equatable, Identifiable, Codable, Hashable {
    let columnLabel: String
    let rowLabel: String
    let value: Double
    let xValue: Double
    let yValue: Double
    let id: UUID

    init(columnLabel: String, rowLabel: String, value: Double, xValue: Double, yValue: Double, id: UUID = UUID()) {
        self.columnLabel = columnLabel
        self.rowLabel = rowLabel
        self.value = value
        self.xValue = xValue
        self.yValue = yValue
        self.id = id
    }
}
