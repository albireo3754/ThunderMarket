//
//  TownListeUseCaseProtocol.swift
//  ThunderMarket
//
//  Created by 윤상진 on 2021/10/25.
//

import Foundation
import Combine

protocol TownListUseCaseProtocol {
    func setTownList(with position: Position) -> AnyPublisher<Bool, Error>
    func lazySearch() -> AnyPublisher<[String], Error>
}
