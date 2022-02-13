//
//  Queue.swift
//  ThunderMarket
//
//  Created by 윤상진 on 2021/08/22.
//

import Foundation

struct Queue<T> {
    var stack1 = [T]()
    var stack2 = [T]()
    var count: Int {
        return stack1.count + stack2.count
    }
    
    var top: T? {
        if let top = stack2.last {
            return top
        }
        if let top = stack1.first {
            return top
        }
        return nil
    }
    
    mutating func append(_ item: T) {
        stack1.append(item)
    }
    
    @discardableResult
    mutating func pop() -> T? {
        if let lastItem = stack2.popLast() {
            return lastItem
        }
        while let lastItem = stack1.popLast() {
            stack2.append(lastItem)
        }
        if let lastItem = stack2.popLast() {
            return lastItem
        }
        return nil
    }
}
