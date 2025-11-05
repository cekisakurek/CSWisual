//
//  StatsChartResult.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 15.07.24.
//

import Foundation

struct StatsChartResult: Codable, Equatable, Hashable {
    
    // Same as in Wolfram Alfa and in "raster" R package (expressed as a percentage in "raster").
    let coefficientOfVariation: Double?
    let variance: Double?
    
    let mean: Double?
    let std: Double?
    let min: Double?
    let twoFivePercentile: Double?
    let fiveZeroPercentile: Double?
    let sevenFivePercentile: Double?
    let max: Double?
    let kurtosisA: Double?
    let kurtosisB: Double?
    let skewnessA: Double?
    let skewnessB: Double?
    let swilkP: Double?
    let swilkW: Double?
    let isGaussian: String
    
    let median: Double?
    
    let stdErrorOfMean: Double?

    var meanString: String {
        if let mean {
            return String(format: "%.4f", mean)
        } else {
            return "-"
        }
    }

    var stdString: String {
        if let std {
            return String(format: "%.4f", std)
        } else {
            return "-"
        }
    }
    
    var coefficientOfVariationString: String {
        if let coefficientOfVariation {
            return String(format: "%.4f", coefficientOfVariation)
        } else {
            return "-"
        }
    }
    
    var kurtosisAString: String {
        if let kurtosisA {
            return String(format: "%.4f", kurtosisA)
        } else {
            return "-"
        }
    }
    
    var kurtosisBString: String {
        if let kurtosisB {
            return String(format: "%.4f", kurtosisB)
        } else {
            return "-"
        }
    }
    
    var maxString: String {
        if let max {
            return String(format: "%.4f", max)
        } else {
            return "-"
        }
    }
    
    var medianString: String {
        if let median {
            return String(format: "%.4f", median)
        } else {
            return "-"
        }
    }
    
    var minString: String {
        if let min {
            return String(format: "%.4f", min)
        } else {
            return "-"
        }
    }
    
    var skewnessAString: String {
        if let skewnessA {
            return String(format: "%.4f", skewnessA)
        } else {
            return "-"
        }
    }
    
    var skewnessBString: String {
        if let skewnessB {
            return String(format: "%.4f", skewnessB)
        } else {
            return "-"
        }
    }
    
    var stdErrorOfMeanString: String {
        if let stdErrorOfMean {
            return String(format: "%.4f", stdErrorOfMean)
        } else {
            return "-"
        }
        
    }
    
    var varianceString: String {
        if let variance {
            return String(format: "%.4f", variance)
        } else {
            return "-"
        }
        
    }
}
