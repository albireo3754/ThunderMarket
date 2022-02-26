//
//  AddressInteractor.swift
//  ThunderMarket
//
//  Created by 윤상진 on 2022/02/06.
//

import RIBs
import RxSwift
import Foundation

enum AddressInteractorError: Error {
    case failSetAddress
}

protocol MapRepositoriable {
    func findMap() -> Map?
}

protocol AddressRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol AddressPresentable: Presentable {
    var listener: AddressPresentableListener? { get set }
    func updateTable()
}

protocol AddressListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class AddressInteractor: PresentableInteractor<AddressPresentable>, AddressInteractable, AddressPresentableListener {
    
    weak var router: AddressRouting?
    weak var listener: AddressListener?
    
    var addressList: [String?] = []

    private var mapRepository: MapRepositoriable?
    private var addressFinder: AddressFinder?
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: AddressPresentable, mapRepository: MapRepositoriable) {
        self.mapRepository = mapRepository
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    func initAddress() {
        addressList = []
    }
    
    func setCenter(position: Position) -> Result<Void, Error> {
        guard let map = mapRepository?.findMap() else {
            return .failure(AddressInteractorError.failSetAddress)
        }

        addressFinder = AddressFinder(center: position, map: map)
        return .success(())
    }
    
    func searchAddressList(count: Int) {
        guard let extraAddress = addressFinder?.search(count: count) else {
            return
        }
        addressList.append(contentsOf: extraAddress)
        presenter.updateTable()
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
