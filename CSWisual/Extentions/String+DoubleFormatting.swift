//
//  String+DoubleFormatting.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 27.06.24.
//

import Foundation

extension String {
    func isValidDouble(maxDecimalPlaces: Int) -> Bool {
        // Use NumberFormatter to check if we can turn the string into a number
        // and to get the locale specific decimal separator.
        let formatter = NumberFormatter()

        formatter.allowsFloats = true // Default is true, be explicit anyways
        let decimalSeparator = "."
        // formatter.decimalSeparator ?? "."
        // Gets the locale specific decimal separator. 
        // If for some reason there is none we assume "." is used as separator.
        formatter.decimalSeparator = decimalSeparator
        // Check if we can create a valid number. (The formatter creates a NSNumber, but
        // every NSNumber is a valid double, so we're good!)
        if formatter.number(from: self) != nil {
            // Split our string at the decimal separator
            let split = self.components(separatedBy: decimalSeparator)

            // Depending on whether there was a decimalSeparator we may have one
            // or two parts now. If it is two then the second part is the one after
            // the separator, aka the digits we care about.
            // If there was no separator then the user hasn't entered a decimal
            // number yet and we treat the string as empty, succeeding the check
            let digits = split.count == 2 ? split.last ?? "" : ""

            // Finally check if we're <= the allowed digits
            return digits.count <= maxDecimalPlaces
        }

        return false // couldn't turn string into a valid number
    }
}
