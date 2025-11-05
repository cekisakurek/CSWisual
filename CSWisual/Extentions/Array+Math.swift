//
//  Array+Math.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 27.06.24.
//

import Foundation
import SigmaSwiftStatistics

extension Array where Element == Double {

    func density() -> [Double: Double] {
        guard let kernel = KernelDensityEstimation(self)
        else { return ([:]) }
        return self.reduce([Double: Double]()) { partialResult, value in
            var results = partialResult
            let density = kernel.evaluate(value)
            results[value] = density
            return results
        }
    }

    func probabilityDistribution() -> [Double: Double] {
        let mean = Sigma.average(self) ?? 1
        let std = Sigma.standardDeviationSample(self) ?? 0
        return self.sorted()
            .reduce([Double: Double]()) { partialResult, value in
                let count = Double(self.count)
                var result = partialResult
                let index = result.count
                var pValue = 0.0
                if index == 0 {
                    pValue = 1.0 - Double(pow(0.5, 1.0 / count))
                } else if index == self.count - 1 {
                    pValue = Double(pow(0.5, 1.0 / count))
                } else {
                    pValue = (Double(index) - 0.3175) / (count + 0.365)
                }
                let key = Sigma.normalQuantile(p: pValue, μ: mean, σ: std)!
                result[key] = value
                return result
            }
    }

    func binEdges() -> [BinEdge] {
        let count = Double(self.count)
        let maxValue = self.max() ?? 0.0
        let minValue = self.min() ?? Double.greatestFiniteMagnitude

        let percentile3 = Sigma.percentile(self, percentile: 0.75)!
        let percentile1 = Sigma.percentile(self, percentile: 0.25)!

        let irq = percentile3 - percentile1
        let value =  2 * irq * pow(count, -1.0/3.0)

        let hValue = value > 0 ? value : log2(count) + 1

        let binSize = Swift.min(Swift.max(Int(round((maxValue - minValue) / hValue)), 1), 100)

        let binEdges: [BinEdge] = (0..<binSize).map {
            let lower = minValue + (hValue * Double($0))
            let upper = (minValue + hValue) + hValue * Double($0)

            let values = self
                .sorted()
                .reduce([Double: Int]()) { partialResult, value in
                    var results = partialResult
                    if value >= lower && value < upper {
                        if results[value] != nil {
                            results[value]! += 1
                        } else {
                            results[value] = 1
                        }
                    }
                    return results
                }
            let edge = BinEdge(lowerValue: lower, upperValue: upper, values: values)
            return edge
        }
        return binEdges
    }

    func normalized() -> [Double] {
        let max = self.max() ?? 0.0
        let min = self.min() ?? Double.greatestFiniteMagnitude
        return self.map({ ($0 - min) / (max - min) })
    }
    
    func swilk() -> (Double, Double)? {
        guard self.count > 0 else { return nil }
        let arr = self.sorted()

        let (wValue, pValue, error) = CSWisual.swilk(x: arr)

        if error == .noError {
            return (wValue, pValue)
        }
        return nil
    }
}
