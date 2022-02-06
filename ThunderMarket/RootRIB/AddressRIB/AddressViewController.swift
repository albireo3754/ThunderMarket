//
//  AddressViewController.swift
//  ThunderMarket
//
//  Created by 윤상진 on 2022/02/06.
//

import CoreLocation
import UIKit

import RIBs
import RxSwift
import SnapKit

protocol AddressPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class AddressViewController: UIViewController, AddressPresentable, AddressViewControllable {

    weak var listener: AddressPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildCoreLocationManager()
        buildBackgroundView()
        buildFindAddressButton()
        buildAddressTableView()
    }
    
    private var locationManager: CLLocationManager?
    private var findAddressButton: UIButton?
    private var addressTableView: UITableView?
    private let disposeBag = DisposeBag()
    
    private func buildCoreLocationManager() {
        locationManager = nil
        locationManager = CLLocationManager()
        locationManager?.delegate = self
    }
    
    private func buildBackgroundView() {
        view.backgroundColor = .white
    }
    
    private func buildFindAddressButton() {
        let findAddressButton = UIButton()
        findAddressButton.backgroundColor = .systemYellow
        findAddressButton.setTitle("현재위치로 찾기", for: .normal)
        self.findAddressButton = findAddressButton
        
        view.addSubview(findAddressButton)
        findAddressButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.topMargin.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(50)
        }
        
        findAddressButton.rx.tap.bind {
            self.buildCoreLocationManager()
        }
        .disposed(by: disposeBag)
    }
    
    private func buildAddressTableView() {
        let addressTableView = UITableView()
        self.addressTableView = addressTableView
        
        view.addSubview(addressTableView)
        guard let findAddressButton = findAddressButton else {
            return
        }

        addressTableView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(findAddressButton.snp.bottom)
        }
        
        addressTableView.delegate = self
        addressTableView.dataSource = self
        
        addressTableView.register(AddressTableViewCell.self)
    }
}

extension AddressViewController: UITableViewDelegate {
    
}

extension AddressViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewCell: AddressTableViewCell = tableView.dequeueReusableCell() else {
            return UITableViewCell()
        }
        tableViewCell.configure(with: "우리집")
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "근처 동네"
    }
}

extension AddressViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
//        townListsViewModel?.fetchMapData(with: (x: location.coordinate.longitude, y: location.coordinate.latitude))
//        townListsViewModel?.search()
//        locationManager.stopUpdatingLocation()
//        activityIndicator.stopAnimating()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
    case .authorizedAlways, .authorizedWhenInUse:
        print("GPS 권한 설정됨")
        self.locationManager?.startUpdatingLocation()
    case .restricted, .notDetermined:
        print("GPS 권한 설정되지 않음")
        getLocationUsagePermission()
    case .denied:
        print("GPS 권한 요청 거부됨")
        showDontHaveLocationAccessRights()
    default:
        print("GPS: Default")
    }
    }
    
    private func getLocationUsagePermission() {
        self.locationManager?.requestWhenInUseAuthorization()
    }
    
    private func showDontHaveLocationAccessRights() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        let alert = UIAlertController(title: "위치정보 이용에 대한 엑세스 권한이 없어요", message: "설정 앱에서 권한을 수정할 수 있어요.", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let setting = UIAlertAction(title: "지금 설정하기", style: .default, handler: { _ in UIApplication.shared.open(url)})
        alert.addAction(cancel)
        alert.addAction(setting)
        present(alert, animated: true, completion: nil)
    }
}