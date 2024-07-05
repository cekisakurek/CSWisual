//
//  Math.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 26.06.24.
//

import Foundation
import SigmaSwiftStatistics

// swiftlint:disable identifier_name
func leastSquaresRegression(_ points: [Double: Double]) -> (Double, Double) {
    var total_x = 0.0
    var total_xy = 0.0
    var total_y = 0.0
    var total_x2 = 0.0
    for point in points {
        total_x += point.key
        total_y += point.value
        total_xy += point.key * point.value
        total_x2 += pow(point.key, 2)
    }
    let N = Double(points.count)
    let m = (N * total_xy - total_x * total_y) / (N * total_x2 - pow(total_x, 2))
    let b = (total_y - m * total_x) / N
    return (b, m)
}
// swiftlint:enable identifier_name
