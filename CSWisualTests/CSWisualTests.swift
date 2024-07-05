//
//  CSWisualTests.swift
//  CSWisualTests
//
//  Created by Cihan Emre Kisakurek on 25.06.24.
//

import XCTest
import ComposableArchitecture

@testable import CSWisual

@MainActor
final class CSWisualTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() async throws {
        
//        let url = Bundle.main.url(forResource: "BitcoinTest", withExtension: "csv")!
//        let reader = try await CSVFileReader.liveValue.readFromURL(url)
//        
//        
//        
//        let columns = reader.columns
//        
//        let store = TestStore(initialState: ChartsContainerModule.State(columns: columns)) {
//            ChartsContainerModule()
//        }
//        
//        await store.send(\.binding.selectedHeaders, ["Id"]) {
//            $0.charts = []
//        }
//        
        
        
//
//            await store.send(.incrementButtonTapped) {
//              $0.count = 1
//            }
//            await store.send(.decrementButtonTapped) {
//              $0.count = 0
//            }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
