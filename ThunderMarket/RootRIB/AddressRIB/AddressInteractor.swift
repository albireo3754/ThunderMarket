//
//  AddressInteractor.swift
//  ThunderMarket
//
//  Created by 윤상진 on 2022/02/06.
//

import RIBs
import RxSwift

protocol MapRepository {
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
    
    var mapRepository: MapRepository?
    var addressFinder: AddressFinder?
    var addressList: [String] = []

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: AddressPresentable, mapRepository: MapRepository) {
        self.mapRepository = mapRepository
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    func setCenter(position: Position) {
        guard let map = mapRepository?.findMap() else {
            //TODO: Map Error처리 하기
            return
        }

        addressFinder = AddressFinder(center: position, map: map)
    }
    
    func searchExtraAddress(count: Int) {
        guard let extraAddress = addressFinder?.search(count: count) else {
            return
        }
        addressList.append(contentsOf: extraAddress)
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
