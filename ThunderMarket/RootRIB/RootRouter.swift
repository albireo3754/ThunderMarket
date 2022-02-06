//
//  RootRouter.swift
//  ThunderMarket
//
//  Created by 윤상진 on 2022/02/05.
//

import RIBs

protocol RootInteractable: Interactable, LoggedOutListener, AddressListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
    func push(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    private let loggedOutBuilder: LoggedOutBuildable
    private let addressBuilder: AddressBuildable
    
    init(interactor: RootInteractable, viewController: RootViewControllable, loggedOutBuilder: LoggedOutBuildable, addressBuilder: AddressBuildable) {
        self.loggedOutBuilder = loggedOutBuilder
        self.addressBuilder = addressBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    } 
    
    override func didLoad() {
        super.didLoad()
        routeToLoggedOut()
    }
    
    func routeToLoggedOut() {
        let loggedOut = loggedOutBuilder.build(withListener: interactor)
        attachChild(loggedOut)
        viewController.present(viewController: loggedOut.viewControllable)
    }
    
    func pushAddress() {
        let address = addressBuilder.build(withListener: interactor)
        attachChild(address)
        viewController.push(viewController: address.viewControllable)
    }
}
