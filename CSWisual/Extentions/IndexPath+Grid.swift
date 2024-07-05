//
//  IndexPath+Grid.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 05.07.24.
//

import Foundation
extension IndexPath {
    init(row: Int, column: Int) {
        self = IndexPath(item: column, section: row)
    }

    var column: Int { item }
    var row: Int { section }
}
