//
//  Repository.swift
//  ThunderMarket
//
//  Created by 윤상진 on 2021/10/20.
//

import Foundation

class MapRepository: MapRepositoriable {
    
    func findMap() -> Map? {
        guard let url = Bundle.main.url(forResource: "map", withExtension: "json") else {
            return nil
        }
    
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        
        guard let town = try? JSONDecoder().decode(Map.self, from: data) else {
            return nil
        }
        return town
    }
}
