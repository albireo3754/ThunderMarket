//
//  AddressRouter.swift
//  ThunderMarket
//
//  Created by 윤상진 on 2022/02/06.
//

import RIBs

protocol AddressInteractable: Interactable {
    var router: AddressRouting? { get set }
    var listener: AddressListener? { get set }
}

protocol AddressViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class AddressRouter: ViewableRouter<AddressInteractable, AddressViewControllable>, AddressRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: AddressInteractable, viewController: AddressViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
