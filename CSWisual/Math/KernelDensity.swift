//
//  KernelDensityEstimation.swift
//  SwiftStats
//
//  Created by Matthew Walker on 9/01/19.
//  Copyright © 2019 Raphael Deem. All rights reserved.
//
// Copied from https://github.com/r0fls/swiftstats/blob/master/SwiftStats/KernelDensityEstimation.swift

import Foundation
import SigmaSwiftStatistics
/**
 Kernel density estimation using a Gaussian kernel and automatic bandwidth
 selection via Silverman's rule-of-thumb.
 */
public class KernelDensityEstimation {
    let data : [Double]
    /** Bandwidth used in evaluate() method */
    public let bandwidth : Double
    let n: Double
    
    /**
     Creates a new instance from an array of Doubles
     
     - Parameters:
       - data: Array of Doubles.  If automatic bandwidth selection is
       required, this arry needs to have no fewer than two values.
       - bandwidth: Either specify the size of the bandwidth (the standard
       deviation of the normal kernel), or specify `nil` to automatically
       select the bandwidth using Silverman's rule-of-thumb.  Note that
       this rule is only appropriate if the data comes from a distribution
       not too dissimilar to a normal distribution.  In other words, you
       will be better served by manually specifying the bandwidth if the
       source distribution is multi-modal.
       See the [Kernel Density Estimation Wikipedia article](https://en.wikipedia.org/wiki/Kernel_density_estimation).
     
     - Returns:
     A new instance of KernelDensityEstimation, or `nil` if `data`
     contained fewer than two values and bandwidth was set to `nil`.
     */
    public init?(_ data: [Double], bandwidth: Double? = nil) {
        self.data = data
        self.n = Double(data.count)
        
        if bandwidth != nil {
            self.bandwidth = bandwidth!
        } else {
            // Silverman's rule-of-thumb; see
            // https://en.wikipedia.org/wiki/Kernel_density_estimation
            
            
            guard let sd = Sigma.standardDeviationSample(data) else {
                return nil
            }
            self.bandwidth = 1.06 * sd * pow(n, Double(-1.0/5.0))
        }
    }
    
    /**
     Evaluates the Kernel Density Estimator at the given value, `x`.
     
     - Parameters:
       - x: The point at which the KDE should be evaluated.
     
     - Returns:
     The density at the specified point, `x`.
     */
    public func evaluate(_ x: Double) -> Double {
        // Go through each data point, calculate its contribution at the
        // given x.
        var result : Double = 0
        for d in data {
            result += gaussianKernel(x, mean: d, sd: bandwidth) / n
        }
        
        return result
    }
    
    /**
     Calculates the density of a Gaussian distribution at location `x`,
     given it has a mean at a specified data point and a standard deviation
     specified as `bandwidth` in the contructor.
     
     - Parameters:
       - x: The point at which the Gaussian distributon should be evaluated.
       - mean: The mean (or centre) of the Gaussian distribution
       - sd: The standard deviation of the Gaussian distribution
     
     - Returns:
     The density at the specified point, `x`, for the specified Gaussian.
     */
    private func gaussianKernel(_ x: Double, mean: Double, sd: Double) -> Double {
        let distribution = Normal(mean: mean, sd: sd)
        return distribution.pdf(x)
    }
}

public class Normal {
    // mean and variance
    var m: Double
    var v: Double

    public init(m: Double, v: Double) {
        self.m = m
        self.v = v
    }
    
    public convenience init(mean: Double, sd: Double) {
        // This contructor takes the mean and standard deviation, which is the more
        // common parameterisation of a normal distribution.
        let variance = pow(sd, 2)
        self.init(m: mean, v: variance)
    }

//    public convenience init?(data: [Double]) {
//        // this calculates the mean twice, since variance()
//        // uses the mean and calls mean()
//        guard let v = Common.variance(data) else {
//            return nil
//        }
//        guard let m = Common.mean(data) else {
//            return nil // This shouldn't ever occur
//        }
//        self.init(m: m, v: v)
//    }

    public func pdf(_ x: Double) -> Double {
        
        return (1/pow(self.v*2*Double.pi,0.5))*exp(-pow(x-self.m,2)/(2*self.v))
    }
    
    public func cdf(_ x: Double) -> Double {
        return (1 + erf((x-self.m)/pow(2*self.v,0.5)))/2
    }


}
