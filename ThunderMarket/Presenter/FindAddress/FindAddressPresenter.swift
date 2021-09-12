//
//  FindAddressPresenter.swift
//  ThunderMarket
//
//  Created by 윤상진 on 2021/09/12.
//

import Foundation

class FindAddressPresenter {
    
    let town: Town
    weak var view: FindAddressViewProtocol?
    init(town: Town, view: FindAddressViewProtocol) {
        self.town = town
    }
}
