//
//  TownListUseCase.swift
//  ThunderMarket
//
//  Created by 윤상진 on 2021/10/11.
//

import Foundation
import Combine

class TownListUseCase {
    typealias Position = TownListsViewModel.Position
    private let localRepository: LocalRepository
    private var town: Town?
    
    init(localRepository: LocalRepository) {
        self.localRepository = localRepository
    }
    
    func setCenterPosition(with position: Position) {
        setCenterPosition(with: position)
    }
    
    func loadMapData(with position: Position) -> AnyPublisher<Bool, Error> {
        if #available(iOS 14.0, *) {
            return localRepository.loadMapData()
                .flatMap {[weak self] map -> AnyPublisher<Bool, Never> in
                    self?.town = Town(center: position, map: map)
                    return Just(true).eraseToAnyPublisher()
                }
                .eraseToAnyPublisher()
            
        } else {
            // Fallback on earlier versions
        }
        return CurrentValueSubject(true).eraseToAnyPublisher()
    }
    
    func search() -> AnyPublisher<[String], Never>? {
        
        return town?.search().publisher
            .collect()
            .eraseToAnyPublisher()
    }
}
