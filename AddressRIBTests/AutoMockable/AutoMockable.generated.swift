// Generated using Sourcery 1.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
@testable import ThunderMarket
import UIKit
import RIBs
import RxSwift
#elseif os(OSX)
import AppKit
#endif
















class AddressListenerMock: AddressListener {

}
class AddressPresentableMock: AddressPresentable {
    var listener: AddressPresentableListener?

    //MARK: - updateTable

    var updateTableCallsCount = 0
    var updateTableCalled: Bool {
        return updateTableCallsCount > 0
    }
    var updateTableClosure: (() -> Void)?

    func updateTable() {
        updateTableCallsCount += 1
        updateTableClosure?()
    }

}
class AddressRoutingMock: AddressRouting {
    var lifecycle: Observable<RouterLifecycle> {
        get { return underlyingLifecycle }
        set(value) { underlyingLifecycle = value }
    }
    var underlyingLifecycle: Observable<RouterLifecycle>!
    var interactable: Interactable {
        get { return underlyingInteractable }
        set(value) { underlyingInteractable = value }
    }
    var underlyingInteractable: Interactable!
    var children: [Routing] = []
    var viewControllable: ViewControllable {
        get { return underlyingViewControllable }
        set(value) { underlyingViewControllable = value }
    }
    var underlyingViewControllable: ViewControllable!

    //MARK: - load

    var loadCallsCount = 0
    var loadCalled: Bool {
        return loadCallsCount > 0
    }
    var loadClosure: (() -> Void)?

    func load() {
        loadCallsCount += 1
        loadClosure?()
    }

    //MARK: - attachChild

    var attachChildCallsCount = 0
    var attachChildCalled: Bool {
        return attachChildCallsCount > 0
    }
    var attachChildReceivedChild: Routing?
    var attachChildReceivedInvocations: [Routing] = []
    var attachChildClosure: ((Routing) -> Void)?

    func attachChild(_ child: Routing) {
        attachChildCallsCount += 1
        attachChildReceivedChild = child
        attachChildReceivedInvocations.append(child)
        attachChildClosure?(child)
    }

    //MARK: - detachChild

    var detachChildCallsCount = 0
    var detachChildCalled: Bool {
        return detachChildCallsCount > 0
    }
    var detachChildReceivedChild: Routing?
    var detachChildReceivedInvocations: [Routing] = []
    var detachChildClosure: ((Routing) -> Void)?

    func detachChild(_ child: Routing) {
        detachChildCallsCount += 1
        detachChildReceivedChild = child
        detachChildReceivedInvocations.append(child)
        detachChildClosure?(child)
    }

}
class MapRepositoriableMock: MapRepositoriable {

    //MARK: - findMap

    var findMapCallsCount = 0
    var findMapCalled: Bool {
        return findMapCallsCount > 0
    }
    var findMapReturnValue: Map?
    var findMapClosure: (() -> Map?)?

    func findMap() -> Map? {
        findMapCallsCount += 1
        if let findMapClosure = findMapClosure {
            return findMapClosure()
        } else {
            return findMapReturnValue
        }
    }

}
