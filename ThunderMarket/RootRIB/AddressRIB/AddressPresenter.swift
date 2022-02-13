//
//  AddressPresenter.swift
//  ThunderMarket
//
//  Created by 윤상진 on 2022/02/07.
//

protocol AddressPresentableListener: AnyObject {
    var addressList: [String?] { get }
    func initAddress()
    func setCenter(position: Position) -> Result<Void, Error>
    func searchAddressList(count: Int)
}
