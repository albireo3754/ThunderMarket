//
//  Town.swift
//  ThunderMarket
//
//  Created by 윤상진 on 2021/07/18.
//

import Foundation

struct Town {
    typealias Point = (x: Double, y: Double)
    private(set) var list = [String]()
    private let map: Map
    private var cnt = 0
    private let dividedUnit = 30
    private var queue = Queue<(i: Int, j: Int)>()
    private var visited: [[Bool]]

    init?(point: Point, map: Map) {
        queue.append((Int((map.i - point.y) * 20), Int((point.x - map.j) * 20)))
        self.map = map
        self.visited = map.visited
    }
}

// MARK: - Search
extension Town {
    mutating func search() {
        dividedBfs()
    }
    
    private mutating func dividedBfs() {
        list = []
        let upperBound = dividedUnit
        let direction = [(1, 0), (0, 1), (-1, 0), (0, -1)]
        while queue.count != 0 {
            guard let (i, j) = queue.top else {
                continue
            }
            for (di, dj) in direction {
                let (ni, nj) = (i + di, j + dj)
                if 0 <= ni && ni < map.n && 0 <= nj && nj < map.m {
                    guard !visited[ni][nj] else {
                        continue
                    }
                    visited[ni][nj] = true
                    queue.append((ni, nj))
                    list.append(contentsOf: map.grid[ni][nj])
                }
                if list.count >= upperBound {
                    return
                }
            }
            queue.pop()
        }
    }
}
