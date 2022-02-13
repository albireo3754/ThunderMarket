//
//  Town.swift
//  ThunderMarket
//
//  Created by 윤상진 on 2021/07/18.
//

import Foundation

class AddressFinder {
    private(set) var list = [String?]()
    private let map: Map
    private var cnt = 0
    private var queue = Queue<(i: Int, j: Int)>()
    private var secondQueue = Queue<String>()
    private var visited: [[Bool]]

    init(center: Position, map: Map) {
        self.queue.append(
            (Int((map.i - center.y) * 20),
             Int((center.x - map.j) * 20)))
        self.map = map
        self.visited = map.visited
    }

    func search(count: Int) -> [String?] {
        return dividedBfs(count: count)
    }
    
    private func dividedBfs(count: Int) -> [String?] {
        list = Array(repeating: nil, count: count)
        let upperBound = count
        let direction = [(1, 0), (0, 1), (-1, 0), (0, -1)]
        var index = 0
        
        while !queue.isEmpty() {
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

                    map.grid[ni][nj].forEach {
                        secondQueue.append($0)
                    }
                    
                }
            }
            queue.pop()
            while !secondQueue.isEmpty() && index < upperBound {
                list[index] = secondQueue.pop()
                index += 1
            }
            if index == count {
                return list
            }
        }
        return list
    }
}
