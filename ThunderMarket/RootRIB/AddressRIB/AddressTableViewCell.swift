//
//  AddressTableViewCell.swift
//  ThunderMarket
//
//  Created by 윤상진 on 2022/02/06.
//

import UIKit

class AddressTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildAddressLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with text: String) {
        addressLabel?.text = text
    }
    
    private var addressLabel: UILabel?
    
    private func buildAddressLabel() {
        let addressLabel = UILabel()
        self.addressLabel = addressLabel
        addSubview(addressLabel)
        
        addressLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
    }
}
