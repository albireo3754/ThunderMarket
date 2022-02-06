//
//  UITableView+Extension.swift
//  ThunderMarket
//
//  Created by 윤상진 on 2022/02/06.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_ cellClass: T.Type) {
        register(T.self, forCellReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>() -> T? {
        return self.dequeueReusableCell(withIdentifier: T.identifier) as? T
    }
}

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
