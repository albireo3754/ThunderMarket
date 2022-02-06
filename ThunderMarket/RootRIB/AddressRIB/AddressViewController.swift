//
//  AddressViewController.swift
//  ThunderMarket
//
//  Created by 윤상진 on 2022/02/06.
//

import RIBs
import RxSwift
import UIKit

protocol AddressPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class AddressViewController: UIViewController, AddressPresentable, AddressViewControllable {

    weak var listener: AddressPresentableListener?
}
