//
//  HeatmapChartResult.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 05.07.24.
//

import Foundation

struct HeatmapChartResult: Equatable, Codable, Hashable {
    let data: [MatrixEntry]
    let labels: [String]
}
