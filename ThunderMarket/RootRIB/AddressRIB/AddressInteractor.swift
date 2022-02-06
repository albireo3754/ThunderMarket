//
//  AddressInteractor.swift
//  ThunderMarket
//
//  Created by 윤상진 on 2022/02/06.
//

import RIBs
import RxSwift

protocol AddressRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol AddressPresentable: Presentable {
    var listener: AddressPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol AddressListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class AddressInteractor: PresentableInteractor<AddressPresentable>, AddressInteractable, AddressPresentableListener {

    weak var router: AddressRouting?
    weak var listener: AddressListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: AddressPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
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
