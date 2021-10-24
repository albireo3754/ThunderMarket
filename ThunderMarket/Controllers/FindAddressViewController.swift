//
//  FindAddressViewController.swift
//  ThunderMarket
//
//  Created by 윤상진 on 2021/07/18.
//

import UIKit
import CoreLocation
import Combine

class FindAddressViewController: UIViewController {
    private var isLoading = false
    private var list: [String]!
    private var locationManager: CLLocationManager!
    private var activityIndicator: UIActivityIndicatorView!
    private var presenter: FindAddressPresenterProtocol!
    private var townListsViewModel: TownListsViewModel?
    private var cancellableSet: Set<AnyCancellable> = []
    @IBOutlet weak var failFindAddressView: UIView!
    @IBOutlet weak var mapTableView: UITableView!
    
    
    override func viewDidLoad() {
        // MARK: Set LocationManger
        var testField = UITextField()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        renderActivityIndicator()
        // MARK: Set Model
        findAddressByCurrentLocation()
        configureViewModel()
        super.viewDidLoad()
    }
    
    private func configureViewModel() {
        let townUseCase = TownListUseCase(localRepository: MapRepository())
        let townViewModel = TownListsViewModel(townUseCase: townUseCase)
//        let jsonDecoder = JSONDecoder()
//        guard let dataAsset = NSDataAsset(name: "map"),
//              let map = try? jsonDecoder.decode(Map.self, from: dataAsset.data) else {
//            fatalError("내부 지도 파일이 망가졌습니다.")
//        }
        townListsViewModel?.$fetchData.sink(receiveValue: { [weak self] in
            if $0 {
                self?.mapTableView.reloadData()
            }
        })
            .store(in: &cancellableSet)
        
        townListsViewModel?.$lastSection.sink(receiveValue: { [weak self] in
            self?.mapTableView.reloadSections(IndexSet(integer: $0), with: .automatic)
        })
            .store(in: &cancellableSet)
        
//        townListsViewModel.isFindAddress.listner = { [weak self] isFindAddress in
//            guard let successView = self?.mapTableView,
//                  let failView = self?.failFindAddressView
//            else {
//                return
//            }
//            DispatchQueue.main.async {
//                if isFindAddress {
//                    self?.view.insertSubview(successView, aboveSubview: failView)
//                } else {
//                    self?.view.insertSubview(successView, belowSubview: failView)
//                }
//            }
//
//        }
        
    }
    
    private func renderActivityIndicator() {
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = self.view.center
        activityIndicator.color = .systemYellow
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        self.view.addSubview(activityIndicator)
    }
    
    func findAddressByCurrentLocation() {
        self.locationManager.startUpdatingLocation()
        activityIndicator.startAnimating()
    }
    
    @IBAction func clickToFindAddressByCurrentLocation(_ sender: Any) {
    }

    @IBAction func popView(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPosition = scrollView.contentOffset.y
        let y = mapTableView.contentSize.height - scrollView.frame.height
        if y - scrollPosition < CGFloat(150) && !self.isLoading {
            self.isLoading = true
            townListsViewModel?.search()
        }
    }

}

extension FindAddressViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return townListsViewModel?.townListsDataSource.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "근처 동네"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return townListsViewModel?.townListsDataSource[section].count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NearTownCell", for: indexPath)
        cell.textLabel?.text = townListsViewModel?.townListsDataSource[indexPath.section][indexPath.row]
        self.isLoading = false
        return cell
    }
}

extension FindAddressViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        townListsViewModel?.fetchMapData(with: (x: location.coordinate.longitude, y: location.coordinate.latitude))
        townListsViewModel?.search()
        locationManager.stopUpdatingLocation()
        activityIndicator.stopAnimating()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {

    case .authorizedAlways, .authorizedWhenInUse:
        print("GPS 권한 설정됨")
        self.locationManager.startUpdatingLocation()
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
    
    func getLocationUsagePermission() {
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func showDontHaveLocationAccessRights() {
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

extension FindAddressViewController: FindAddressViewProtocol {
}
