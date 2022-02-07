//
//  AddressInteractorTests.swift
//  AddressRIBTests
//
//  Created by 윤상진 on 2022/02/07.
//

@testable import ThunderMarket
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
        
        interactor = AddressInteractor(presenter: presenter, mapRepository: mapRepository)
        interactor.listener = listener
        interactor.router = router
        presenter.listener = interactor
        interactor.activate()
    }

    // MARK: - Tests

    func test_지도는_center를_정할때마다_작동한다() {
        // Given
        
        // When
        interactor.setCenter(position: (x: 0, y: 0))
        interactor.setCenter(position: (x: 0, y: 0))

        // Then
        expect(self.mapRepository.findMapCallsCount) == 2
        
    }
}
