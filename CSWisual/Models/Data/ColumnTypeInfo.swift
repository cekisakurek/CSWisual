//
//  ColumnTypeInfo.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 03.07.24.
//

import Foundation

extension CSVData.Column {
    struct TypeInfo: Equatable {
        let unknownTypeCount: Int
        let intTypeCount: Int
        let doubleTypeCount: Int
        let stringTypeCount: Int
        let dateTypeCount: Int
        let uniqueValues: Set<String>
        
        var uniqueCount: Int {
            uniqueValues.count
        }
    }
}
