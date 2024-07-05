//
//  CSVColumn+Private.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 03.07.24.
//

import Foundation

extension CSVData.Column {
    
    static internal func findType(data: [String]) -> TypeInfo {
        // Unknown type is also means empty
        var unknownTypeCount = 0
        var intTypeCount = 0
        var doubleTypeCount = 0
        var stringTypeCount = 0
        var dateTypeCount = 0
        var uniqueSet = Set<String>()
        for value in data {
            let type = Self.typeOf(value: value)
            uniqueSet.insert(value)
            switch type {
                case .int:
                    intTypeCount += 1
                case .double:
                    doubleTypeCount += 1
                case .string:
                    stringTypeCount += 1
                case .date:
                    dateTypeCount += 1
                case .unknown:
                    fallthrough
                default:
                    unknownTypeCount += 1
                    break
            }
        }
        return TypeInfo(
            unknownTypeCount: unknownTypeCount,
            intTypeCount: intTypeCount,
            doubleTypeCount: doubleTypeCount,
            stringTypeCount: stringTypeCount,
            dateTypeCount: dateTypeCount,
            uniqueValues: uniqueSet
        )
    }
    
    private static func typeOf(value: String) -> ColumnType {
        
        guard !value.isEmpty else { return .unknown }
        
        let val = value.replacingOccurrences(of: ",", with: ".")
        
        if let f = Double(val) {
            if floor(f) == f {
                return .int
            }
            else {
                return .double
            }
        }
        else {
            let dateFormatter = DateFormatter()
            // TODO: add more date formats for autodetect
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if let _ = dateFormatter.date(from: value) {
                return .date
            }
            
            return .string
        }
    }
}
