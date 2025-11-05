//
//  ChartType.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 05.07.24.
//

import Foundation

enum ChartType: String, CaseIterable, Identifiable, Codable, Hashable {
    case stats
    case probability
    case distribution
    case heatmap
    var id: String { self.rawValue }
}
