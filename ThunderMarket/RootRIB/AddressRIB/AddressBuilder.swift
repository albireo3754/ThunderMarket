//
//  AddressBuilder.swift
//  ThunderMarket
//
//  Created by 윤상진 on 2022/02/06.
//

import RIBs

protocol AddressDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class AddressComponent: Component<AddressDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol AddressBuildable: Buildable {
    func build(withListener listener: AddressListener) -> AddressRouting
}

final class AddressBuilder: Builder<AddressDependency>, AddressBuildable {

    override init(dependency: AddressDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: AddressListener) -> AddressRouting {
        let component = AddressComponent(dependency: dependency)
        let viewController = AddressViewController()
        let interactor = AddressInteractor(presenter: viewController, mapRepository: MapRepository())
        interactor.listener = listener
        return AddressRouter(interactor: interactor, viewController: viewController)
    }
}
