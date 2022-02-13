//
//  MapRepositoryTests.swift
//  MapRepositoryTests
//
//  Created by 윤상진 on 2022/02/13.
//

import XCTest
@testable import ThunderMarket

import Nimble

class MapRepositoryTests: XCTestCase {
    var mapRepository: MapRepository!
    
    override func setUpWithError() throws {
        mapRepository = MapRepository()
    }

    override func tearDownWithError() throws {
        mapRepository = nil
    }

    func test_findMap은_Map을_불러온다() throws {
        expect(self.mapRepository.findMap()).notTo(beNil())
        expect(type(of: self.mapRepository.findMap()!) == Map.self) == true
    }

}
