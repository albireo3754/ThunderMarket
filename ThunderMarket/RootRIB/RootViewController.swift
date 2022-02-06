//
//  RootViewController.swift
//  ThunderMarket
//
//  Created by 윤상진 on 2022/02/05.
//

import RIBs
import RxSwift
import UIKit

protocol RootPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class RootViewController: UINavigationController, RootPresentable, RootViewControllable {
    func present(viewController: ViewControllable) {
        show(viewController.uiviewController, sender: nil)
    }
    
    func dismiss(viewController: ViewControllable) {
        if presentedViewController == viewController.uiviewController {
            dismiss(animated: true, completion: nil)
        }
    }

    weak var listener: RootPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
