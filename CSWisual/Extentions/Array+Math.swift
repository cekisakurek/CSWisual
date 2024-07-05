//
//  Array+Math.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 27.06.24.
//

import Foundation
import SigmaSwiftStatistics

extension Array where Element == Double {
    
    func frequencies() -> [Double: Double] {
        guard let kernel = KernelDensityEstimation(self)
        else { return ([:]) }
        return self.reduce([Double:Double]()) { partialResult, p in
            var results = partialResult
            let density = kernel.evaluate(p)
            results[p] = density
            return results
        }
    }
    
    func probabilityDistribution() -> [Double: Double] {
        self.sorted()
            .reduce([Double: Double]()) { partialResult, value in
                let count = Double(self.count)
                var result = partialResult
                let i = result.count
                var q = 0.0
                if i == 0 {
                    q = 1.0 - Double(pow(0.5, 1.0 / count))
                }
                else if i == self.count - 1 {
                    q = Double(pow(0.5, 1.0 / count))
                }
                else {
                    q = (Double(i) - 0.3175) / (count + 0.365)
                }
                let n = Sigma.normalQuantile(p: q, μ: 0, σ: 1)!
                result[n] = value
                return result
            }
    }
    
    func binEdges() -> [BinEdge] {
        let n = Double(self.count)
        let maxValue = self.max() ?? 0.0
        let minValue = self.min() ?? Double.greatestFiniteMagnitude
        
        let q3 = Sigma.percentile(self, percentile: 0.75)!
        let q1 = Sigma.percentile(self, percentile: 0.25)!
        
        let irq = q3 - q1
        let value =  2 * irq * pow(n, -1.0/3.0)
        
        let h = value > 0 ? value : log2(n) + 1
        
        let binSize = Swift.min(Swift.max(Int(round((maxValue - minValue) / h)), 1), 100)
        
        let binEdges: [BinEdge] = (0..<binSize).map {
            let lower = minValue + (h * Double($0))
            let upper = (minValue + h) + h * Double($0)
            
            let values = self
                .sorted()
                .reduce([Double: Int]()) { partialResult, value in
                    var results = partialResult
                    if value >= lower && value < upper {
                        if results[value] != nil {
                            results[value]! += 1
                        }
                        else {
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
}
