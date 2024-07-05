//
//  CSVData.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 03.07.24.
//

import Foundation

struct CSVData: Equatable {
    let raw: [[String]]
    let headers: [String]
    let columns: [Column]
}
