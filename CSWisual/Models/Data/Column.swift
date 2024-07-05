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
            } else if info.stringTypeCount > (info.doubleTypeCount + info.intTypeCount + info.dateTypeCount) {
                return .string
            } else if info.doubleTypeCount > (info.stringTypeCount + info.intTypeCount + info.dateTypeCount) {
                return .double
            } else if info.intTypeCount > (info.stringTypeCount + info.doubleTypeCount + info.dateTypeCount) {
                return .int
            } else {
                return .unknown
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

        func asInt() -> [Int] {
            self.data.compactMap(Int.init)
        }

        var isNumber: Bool {
            return  type == .double || type == .int
        }
    }
}
