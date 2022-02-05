//
//  FindAddressTests.swift
//  FindAddressTests
//
//  Created by 윤상진 on 2021/10/25.
//

import XCTest
import Combine

class TownListViewModelTests: XCTestCase {
    struct TownListUseCaseStub: TownListUseCaseProtocol {
        func setTownList(with position: Position) -> AnyPublisher<Bool, Error> {
            return Future<Bool, Error> { promise in
                promise(.success(true))
            }.eraseToAnyPublisher()
        }
        
        func lazySearch() -> AnyPublisher<[String], Error> {
            return Future<[String], Error> { promise in
                promise(.success(Array.init(repeating: "Test", count: 30)))
            }.eraseToAnyPublisher()
        }
        
        
    }

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
