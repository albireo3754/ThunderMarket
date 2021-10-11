//
//  TownViewModel.swift
//  ThunderMarket
//
//  Created by 윤상진 on 2021/09/19.
//

import Foundation
import CoreGraphics

class TownListsViewModel {
    var isFindAddress: Observable<Bool>
    var town: Observable<Town?>
    var townViewModels: [TownViewModel]
    var map: Map
    var row: Int {
        return townViewModels.count
    }
    
    init(map: Map) {
        self.map = map
        self.town = Observable(value: nil)
        self.townViewModels = []
        self.isFindAddress = Observable(value: false)
    }
    
    func setTown(with point: (x: Double, y: Double)) {
        guard let town = Town(point: point, map: map) else {
            return
        }
        self.town.value = town
    }
    
    func search() {
        DispatchQueue.global().async { [weak self] in
            self?.town.value?.search()
            guard let town = self?.town.value?.list else {
                return
            }
            var a = 0
            for address in town {
                for _ in 1...(1000000) {
                    a += 1
                    a -= 1
                }
                self?.townViewModels.append(TownViewModel(address: address))
            }
            if self?.isFindAddress.value == false {
                self?.isFindAddress.value = true
            }
        }
    }
}
