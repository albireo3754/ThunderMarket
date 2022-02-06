//
//  AddressFinderTests.swift
//  AddressFinderTests
//
//  Created by 윤상진 on 2022/02/06.
//

import XCTest

class AddressFinderTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        AddressFinder(center: (0, 0), map: Map(i: 0, j: 0, scale: 0, grid: [[[]]]))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
