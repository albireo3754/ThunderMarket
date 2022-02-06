//
//  RootComponent+Address.swift
//  ThunderMarket
//
//  Created by 윤상진 on 2022/02/06.
//

import RIBs

/// The dependencies needed from the parent scope of Root to provide for the Address scope.
// TODO: Update RootDependency protocol to inherit this protocol.
protocol RootDependencyAddress: Dependency {
    // TODO: Declare dependencies needed from the parent scope of Root to provide dependencies
    // for the Address scope.
}

extension RootComponent: AddressDependency {

    // TODO: Implement properties to provide for Address scope.
}
