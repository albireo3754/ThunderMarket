//
//  Town.swift
//  ThunderMarket
//
//  Created by 윤상진 on 2021/07/18.
//

import Foundation

class Town {
    var list = [String]()
    var cnt = 0
    init() {
        append()
    }
    
    func append() {
        let temp = cnt * 30
        for i in (temp + 1)...(temp + 30) {
            list.append("서울\(i)번지")
        }
        cnt += 1
    }
}
