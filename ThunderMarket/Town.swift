//
//  Town.swift
//  ThunderMarket
//
//  Created by 윤상진 on 2021/07/18.
//

import UIKit

class Town {
    var list = [String]()
    var map: Map
    var cnt = 0
    var queue = Queue<(i: Int, j: Int)>()
    var visited: [[Bool]]
    
    // TODO: - 시작시 좌표를 받아야함
    init?() {
        guard let dataAsset = NSDataAsset(name: "map") else {
            return nil
        }
        let jsonDecoder = JSONDecoder()
        guard let map = try? jsonDecoder.decode(Map.self, from: dataAsset.data) else {
            return nil
        }
        queue.append((50, 50))
        self.map = map
        self.visited = map.visited
    }
}

// MARK: - Search
extension Town {
    // TODO: - 이런 식으로 작성하면 메모리에 문제가 되지않을까?????
    func searchNear() -> [String] {
        bfs()
        return list
    }
    
    private func bfs() {
        cnt += 1
        let upperBound = cnt * 30
        let direction = [(1, 0), (0, 1), (-1, 0), (0, -1)]
        while queue.count != 0 {
            guard let (i, j) = queue.pop() else {
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
            }
            if list.count > upperBound {
                break
            }
        }
    }
}
