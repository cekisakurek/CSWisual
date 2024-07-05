//
//  Double+Round.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 27.06.24.
//

import Foundation

extension Double {
    
    func roundedUp(to places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded(.up) / divisor
    }

    func roundedDown(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded(.down) / divisor
    }

    func string(fractionDigits:Int) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = fractionDigits
        formatter.maximumFractionDigits = fractionDigits
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
