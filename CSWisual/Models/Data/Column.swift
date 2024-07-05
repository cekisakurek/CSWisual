//
//  CSVColumn.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 03.07.24.
//

import Foundation

extension CSVData {
    
    struct Column: Equatable {
        let name: String
        let data: [String]
        let info: TypeInfo
        
        var type: ColumnType {
            
            if info.dateTypeCount > (info.doubleTypeCount + info.intTypeCount + info.stringTypeCount) {
                return .date
            }
            else if info.unknownTypeCount > (info.doubleTypeCount + info.intTypeCount + info.stringTypeCount) {
                return .unknown
            }
            else if info.stringTypeCount > (info.doubleTypeCount + info.intTypeCount) {
                return .string
            }
            else if info.doubleTypeCount > info.intTypeCount {
                return .double
            }
            else {
                return .int
            }
        }
        
        init(name: String, data: [String]) {
            self.name = name
            self.data = data
            self.info = Column.findType(data: data)
        }
        
        func asDouble() -> [Double] {
            self.data.compactMap(Double.init)
        }
        
        var isNumber: Bool {
            return  type == .double || type == .int
        }
    }
    
}
