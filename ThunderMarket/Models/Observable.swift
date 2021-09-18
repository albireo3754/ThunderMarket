//
//  Observable.swift
//  ThunderMarket
//
//  Created by 윤상진 on 2021/09/19.
//

import Foundation

final class Observable<T> {
    typealias Listner = (T) -> Void
    var listner: Listner?
    var value: T {
        didSet {
            listner?(value)
        }
    }
    
    init(value: T) {
        self.value = value
    }
    
    func bind(listner: @escaping Listner) {
        self.listner = listner
        listner(value)
    }
}
