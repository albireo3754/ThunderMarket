//
//  TownViewModel.swift
//  ThunderMarket
//
//  Created by 윤상진 on 2021/09/19.
//

import Foundation
import CoreGraphics
import Combine
import UIKit

class TownListsViewModel {
    typealias Position = (x: Double, y: Double)
    @Published var fetchData: Bool
    @Published var lastSection: Int
    var townListsDataSource: [[String]]
    private var cancellableSet: Set<AnyCancellable>
    private let townUseCase: TownListUseCase
    
    init(townUseCase: TownListUseCase) {
        self.fetchData = false
        self.lastSection = -1
        self.cancellableSet = []
        self.townListsDataSource = []
        self.townUseCase = townUseCase
    }
    
    func fetchMapData(with position: Position) {
        townUseCase.loadMapData(with: position)
            .sink(receiveCompletion: {
                switch $0 {
                case .failure(let error):
                    print(error)
                case .finished:
                    break
                }
            }, receiveValue: {[weak self] in
                self?.fetchData = $0
            })
            .store(in: &cancellableSet)
    }
    
    // TODO: 애니메이션이 너무 빨리 업데이트되서 동시에 업데이트 해야하는 것을 고려해야하면 어떻게해야할까?
    func search() {
        townUseCase.search()?
            .sink(receiveValue: { [weak self] in
                self?.townListsDataSource.append($0)
                guard let lastSection = self?.lastSection else {
                    return
                }
                self?.lastSection += lastSection
            })
            .store(in: &cancellableSet)
            
    }
}
