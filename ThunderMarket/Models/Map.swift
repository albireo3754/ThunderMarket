//
//  Map.swift
//  ThunderMarket
//
//  Created by 윤상진 on 2021/08/22.
//

import Foundation

class Map: Codable {
    let i: Double
    let j: Double
    let scale: Int
    let grid: [[[String]]]
    var visited: [[Bool]] {
        return Array(repeating:  Array(repeating: false, count: grid[0].count), count: grid.count)
    }
    var n: Int {
        return grid.count
    }
    var m: Int {
        return grid[0].count
    }
}
