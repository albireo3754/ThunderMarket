//
//  Repository.swift
//  ThunderMarket
//
//  Created by 윤상진 on 2021/10/20.
//

import Foundation
import Combine

protocol LocalRepository {
    func loadMapData() -> AnyPublisher<Map, Error>
}

class MapRepository: LocalRepository {
    enum loadMapError: Error {
        case loadMapFail
    }
    
    func loadMapData() -> AnyPublisher<Map, Error> {
        let subject = PassthroughSubject<Map, Error>()
        DispatchQueue.global().async {
            guard let url = Bundle.main.url(forResource: "map", withExtension: ".json"),
                  let data = try? Data(contentsOf: url),
                  let town = try? JSONDecoder().decode(Map.self, from: data)
            else {
                subject.send(completion: .failure(loadMapError.loadMapFail))
                return
            }
            subject.send(town)
        }
        return subject.eraseToAnyPublisher()
    }
}
