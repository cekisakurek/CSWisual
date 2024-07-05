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

    var reader = CSVFileReader(readFromURL: { url in 
        let delimiterValue = UnicodeScalar(",")
        let hasHeader = true
        
        guard let stream = InputStream(url: url)
        else {
            throw CSVData.Error.cannotOpenStream
        }
        let reader = try CSVReader(
            stream: stream,
            hasHeaderRow: hasHeader,
            delimiter: delimiterValue
        )
         
        var raw = [[String]]()
        while let row = reader.next() {
            raw.append(row)
        }
                
        let parsed = reader.headerRow?.enumerated().map { index, name  in
            var data = [String]()
            for row in raw {
                data.append(row[index])
            }
            let column = CSVColumn(name: name, data: data)
            return column
        }
        
        return CSVData(data: raw, headers: reader.headerRow!, columns: parsed ?? [])
    })
    
    
    func testBitcoinDateField() async {
        
        let url = Bundle.main.url(forResource: "BitcoinTest", withExtension: "csv")!
        let reader = try! await reader.readFromURL(url)

        let columns = reader.columns
        
        let currentColumn = columns[0]
        XCTAssertEqual(currentColumn.name, "date")
        XCTAssertEqual(currentColumn.type, CSVColumn.ColumnType.date)
        XCTAssertEqual(currentColumn.info.unknownTypeCount, 0)
        XCTAssertEqual(currentColumn.info.doubleTypeCount, 0)
        XCTAssertEqual(currentColumn.info.intTypeCount, 0)
        XCTAssertEqual(currentColumn.info.stringTypeCount, 0)
        XCTAssertEqual(currentColumn.info.dateTypeCount, 3605)
        
    }
    
    func testBitcoinDoubleField() async {
        
        let url = Bundle.main.url(forResource: "BitcoinTest", withExtension: "csv")!
        let reader = try! await reader.readFromURL(url)

        let columns = reader.columns
        
        let currentColumn = columns[1]
        XCTAssertEqual(currentColumn.name, "txVolume(USD)")
        XCTAssertEqual(currentColumn.type, CSVColumn.ColumnType.double)
        XCTAssertEqual(currentColumn.info.unknownTypeCount, 1570)
        XCTAssertEqual(currentColumn.info.doubleTypeCount, 2013)
        XCTAssertEqual(currentColumn.info.intTypeCount, 22)
        XCTAssertEqual(currentColumn.info.stringTypeCount, 0)
        XCTAssertEqual(currentColumn.info.dateTypeCount, 0)
        
    }
    
    func testBitcoinIntField() async {
        
        let url = Bundle.main.url(forResource: "BitcoinTest", withExtension: "csv")!
        let reader = try! await reader.readFromURL(url)

        let columns = reader.columns
        
        let currentColumn = columns[3]
        XCTAssertEqual(currentColumn.name, "txCount")
        XCTAssertEqual(currentColumn.type, CSVColumn.ColumnType.int)
        XCTAssertEqual(currentColumn.info.unknownTypeCount, 0)
        XCTAssertEqual(currentColumn.info.doubleTypeCount, 0)
        XCTAssertEqual(currentColumn.info.intTypeCount, 3605)
        XCTAssertEqual(currentColumn.info.stringTypeCount, 0)
        XCTAssertEqual(currentColumn.info.dateTypeCount, 0)
        
    }
    
    func testRealEstateStringField() async {
        
        let url = Bundle.main.url(forResource: "RealEstateTest", withExtension: "csv")!
        let reader = try! await reader.readFromURL(url)

        let columns = reader.columns
        
        let currentColumn = columns[2]
        XCTAssertEqual(currentColumn.name, "MSZoning")
        XCTAssertEqual(currentColumn.type, CSVColumn.ColumnType.string)
        XCTAssertEqual(currentColumn.info.unknownTypeCount, 0)
        XCTAssertEqual(currentColumn.info.doubleTypeCount, 0)
        XCTAssertEqual(currentColumn.info.intTypeCount, 0)
        XCTAssertEqual(currentColumn.info.stringTypeCount, 1460)
        XCTAssertEqual(currentColumn.info.dateTypeCount, 0)
        
    }

    func testRealEstateUniqueField() async {
        
        let url = Bundle.main.url(forResource: "RealEstateTest", withExtension: "csv")!
        let reader = try! await reader.readFromURL(url)

        let columns = reader.columns
        
        let currentColumn = columns[2]
        XCTAssertEqual(currentColumn.name, "MSZoning")
        XCTAssertEqual(currentColumn.type, CSVColumn.ColumnType.string)
        XCTAssertEqual(currentColumn.info.unknownTypeCount, 0)
        XCTAssertEqual(currentColumn.info.doubleTypeCount, 0)
        XCTAssertEqual(currentColumn.info.intTypeCount, 0)
        XCTAssertEqual(currentColumn.info.stringTypeCount, 1460)
        XCTAssertEqual(currentColumn.info.dateTypeCount, 0)
        
        XCTAssertEqual(currentColumn.info.uniqueCount, 5)
        
    }

}
