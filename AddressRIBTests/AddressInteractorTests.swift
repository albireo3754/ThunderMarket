//
//  AddressInteractorTests.swift
//  AddressRIBTests
//
//  Created by 윤상진 on 2022/02/07.
//

import XCTest

import RIBs
import Nimble
// sourcery:begin: AutoMockable
extension MapRepositoriable {}
extension AddressRouting {}
extension AddressPresentable {}
extension AddressListener {}
// sourcery:end


final class AddressInteractorTests: XCTestCase {
    
    private var interactor: AddressInteractor!
    
    private var presenter: AddressPresentableMock!
    private var mapRepository: MapRepositoriableMock!
    private var listener: AddressListenerMock!
    private var router: AddressRoutingMock!
    // TODO: declare other objects and mocks you need as private vars

    override func setUp() {
        super.setUp()
        listener = AddressListenerMock()
        presenter = AddressPresentableMock()
        router = AddressRoutingMock()
        mapRepository = MapRepositoriableMock()
        let mapStub = Map(i: 0, j: 0, scale: 0, grid: [[[]]])
        mapRepository.findMapClosure = { mapStub }
        
        interactor = AddressInteractor(presenter: presenter, mapRepository: mapRepository)
        interactor.listener = listener
        interactor.router = router
        presenter.listener = interactor
        interactor.activate()
    }

    // MARK: - Tests

    func test_지도는_center를_정할때마다_작동한다() {
        // Given
        let position = (x: 0.0, y: 0.0)
        
        // When
        _ = interactor.setCenter(position: position)
        let result = interactor.setCenter(position: position)

        // Then
        expect(self.mapRepository.findMapCallsCount) == 2
        switch result {
        case .success():
            break
        case .failure(_):
            fail()
        }
    }
    
    func test_주소를_찾아라() {
        // Given
        _ = interactor.setCenter(position: (x: 0, y: 0))
        let addressCount = 30
        
        // When
        interactor.searchAddressList(count: addressCount)
        
        // Then
        expect(self.presenter.updateTableCallsCount) == 1
        expect(self.interactor.addressList.count) == addressCount
    }
    
    func test_이미주소를한번찾았다면_주소를초기화하는것이아니라_기존배열에추가한다() {
        // Given
        _ = interactor.setCenter(position: (x: 0, y: 0))
        let addressCount = 30
        let repeatCount = 2
        
        // When
        for _ in 1...repeatCount {
            interactor.searchAddressList(count: addressCount)
        }
        
        // Then
        expect(self.presenter.updateTableCallsCount) == repeatCount
        expect(self.interactor.addressList.count) == addressCount * repeatCount
    }
}
