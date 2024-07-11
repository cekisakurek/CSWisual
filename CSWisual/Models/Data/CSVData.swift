//
//  CSVData.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 03.07.24.
//

import Foundation

struct CSVData: Equatable, Identifiable, Codable, Hashable {
    let raw: [[String]]
    let headers: [String]
    let columns: [Column]
    let url: URL
    let id: UUID

    init(raw: [[String]], headers: [String], columns: [Column], url: URL, id: UUID = UUID()) {
        self.raw = raw
        self.headers = headers
        self.columns = columns
        self.url = url
        self.id = id
    }
}
