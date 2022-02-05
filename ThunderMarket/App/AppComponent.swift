//
//  AppComponent.swift
//  ThunderMarket
//
//  Created by 윤상진 on 2022/02/05.
//

import RIBs

class AppComponent: Component<EmptyDependency>, RootDependency {

    init() {
        super.init(dependency: EmptyComponent())
    }
}
