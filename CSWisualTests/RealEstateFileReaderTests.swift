//
//  RealestateFileReaderTests.swift
//  CSWisualTests
//
//  Created by Cihan Emre Kisakurek on 05.07.24.
//

import XCTest
import CSV

@testable import CSWisual
@MainActor
final class RealEstateFileReaderTests: XCTestCase {

    let fileReader = CSVFileReader.testValue
    var columns: [CSVData.Column] = []

    override func setUp() async throws {
        let url = Bundle.main.url(forResource: "RealEstateTest", withExtension: "csv")!
        let reader = try await fileReader.readFromURL(url, UnicodeScalar(","))
        self.columns = reader.columns
    }

    func testRealEstateStringField() async {

        let currentColumn = columns[2]
        XCTAssertEqual(currentColumn.name, "MSZoning")
        XCTAssertEqual(currentColumn.type, CSVData.Column.ColumnType.string)
        XCTAssertEqual(currentColumn.info.unknownTypeCount, 0)
        XCTAssertEqual(currentColumn.info.doubleTypeCount, 0)
        XCTAssertEqual(currentColumn.info.intTypeCount, 0)
        XCTAssertEqual(currentColumn.info.stringTypeCount, 1460)
        XCTAssertEqual(currentColumn.info.dateTypeCount, 0)
    }

    func testRealEstateUniqueField() async {

        let currentColumn = columns[2]
        XCTAssertEqual(currentColumn.name, "MSZoning")
        XCTAssertEqual(currentColumn.info.uniqueCount, 5)
    }
}
