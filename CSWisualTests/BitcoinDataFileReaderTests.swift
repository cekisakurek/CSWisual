//
//  FileReaderTests.swift
//  CSWisualTests
//
//  Created by Cihan Emre Kisakurek on 02.07.24.
//

import XCTest
import CSV

@testable import CSWisual
@MainActor
final class FileReaderTests: XCTestCase {

    let fileReader = CSVFileReader.testValue
    var columns: [CSVData.Column] = []

    override func setUp() async throws {
        let url = Bundle.main.url(forResource: "BitcoinTest", withExtension: "csv")!
        let reader = try await fileReader.readFromURL(url, UnicodeScalar(","))
        self.columns = reader.columns
    }

    func testBitcoinDateField() async {

        let currentColumn = columns[0]
        XCTAssertEqual(currentColumn.name, "date")
        XCTAssertEqual(currentColumn.type, CSVData.Column.ColumnType.date)
        XCTAssertEqual(currentColumn.info.unknownTypeCount, 0)
        XCTAssertEqual(currentColumn.info.doubleTypeCount, 0)
        XCTAssertEqual(currentColumn.info.intTypeCount, 0)
        XCTAssertEqual(currentColumn.info.stringTypeCount, 0)
        XCTAssertEqual(currentColumn.info.dateTypeCount, 3605)
    }

    func testBitcoinDoubleField() async {

        let currentColumn = columns[1]
        XCTAssertEqual(currentColumn.name, "txVolume(USD)")
        XCTAssertEqual(currentColumn.type, CSVData.Column.ColumnType.double)
        XCTAssertEqual(currentColumn.info.unknownTypeCount, 1570)
        XCTAssertEqual(currentColumn.info.doubleTypeCount, 2013)
        XCTAssertEqual(currentColumn.info.intTypeCount, 22)
        XCTAssertEqual(currentColumn.info.stringTypeCount, 0)
        XCTAssertEqual(currentColumn.info.dateTypeCount, 0)
    }

    func testBitcoinIntField() async {

        let currentColumn = columns[3]
        XCTAssertEqual(currentColumn.name, "txCount")
        XCTAssertEqual(currentColumn.type, CSVData.Column.ColumnType.int)
        XCTAssertEqual(currentColumn.info.unknownTypeCount, 0)
        XCTAssertEqual(currentColumn.info.doubleTypeCount, 0)
        XCTAssertEqual(currentColumn.info.intTypeCount, 3605)
        XCTAssertEqual(currentColumn.info.stringTypeCount, 0)
        XCTAssertEqual(currentColumn.info.dateTypeCount, 0)
    }
}
