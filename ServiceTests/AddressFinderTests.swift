//
//  AddressFinderTests.swift
//  AddressFinderTests
//
//  Created by 윤상진 on 2022/02/13.
//

import XCTest

import Nimble

class AddressFinderTests: XCTestCase {
    var addressFinder: AddressFinder!
    
    override func setUpWithError() throws {
        let mapStub = Map(i: 0, j: 0, scale: 1, grid: [[]])
        addressFinder = AddressFinder(center: (x: 0, y: 0), map: mapStub)
    }

    override func tearDownWithError() throws {
        addressFinder = nil
    }

    func test_addressFinder는_입력한_크기만큼_반환한다() throws {
        // Given
        let count = 1
        
        // When
        let searchResult = addressFinder.search(count: count)
        
        // Then
        expect(searchResult.count) == count
    }
}
