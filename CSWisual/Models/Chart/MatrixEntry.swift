//
//  MatrixEntry.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 05.07.24.
//

import Foundation

struct MatrixEntry: Equatable, Identifiable {
    let columnLabel: String
    let rowLabel: String
    let value: Double
    let xValue: Double
    let yValue: Double
    let id = UUID()
}
