//
//  TownListUseCase.swift
//  ThunderMarket
//
//  Created by 윤상진 on 2021/10/11.
//

import Foundation
import Combine
import UIKit

enum TownListUseCaseError: Error {
    case NotYetSettingTown
}

class TownListUseCase: TownListUseCaseProtocol {
    private let localRepository: LocalRepository
    private var town: Town?
    
    init(localRepository: LocalRepository) {
        self.localRepository = localRepository
    }
    
    func setTownList(with position: Position) -> AnyPublisher<Bool, Error> {
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
    
    func lazySearch() -> AnyPublisher<[String], Error> {
        let subject = CurrentValueSubject<[String], Error>([])
        if let results = town?.search() {
            subject.send(results)
        } else {
            subject.send(completion: .failure(TownListUseCaseError.NotYetSettingTown))
        }
        return subject
            .eraseToAnyPublisher()
    }
}
