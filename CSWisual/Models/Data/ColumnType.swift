//
//  ColumnType.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 03.07.24.
//

import Foundation

extension CSVData.Column {
    enum ColumnType: String, Equatable, Codable, Hashable {
        case id
        case string
        case int
        case double
        case date
        case unknown
    }
}
