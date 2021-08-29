//
//  FindAddressViewController.swift
//  ThunderMarket
//
//  Created by 윤상진 on 2021/07/18.
//

import UIKit
import CoreLocation

class FindAddressViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    private var isLoading = false
    private var list: [String]!
    private var nearTownCells: Town! = nil
    private var locationManager: CLLocationManager!
    private var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var mapTableView: UITableView!
    
    override func viewDidLoad() {
        let jsonDecoder = JSONDecoder()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        renderActivityIndicator()
        list = []
        findAddressByCurrentLocation()
        super.viewDidLoad()
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
        findAddressByCurrentLocation()
    }

    @IBAction func popView(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "근처 동네"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NearTownCell", for: indexPath)
        cell.textLabel?.text = String(list[indexPath.row])
        self.isLoading = false
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPosition = scrollView.contentOffset.y
        // TODO: - frame이 뭔데?
        let y = mapTableView.contentSize.height - scrollView.frame.height
        print(scrollPosition, y)
        if y - scrollPosition < CGFloat(150) && !self.isLoading {
            self.isLoading = true
            list = nearTownCells?.searchNear()
            mapTableView.reloadData()
        }
    }

}

extension FindAddressViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        guard let nearTownCells = Town(point: (x: location.coordinate.longitude, y: location.coordinate.latitude)) else {
            fatalError("data load 실패");
        }
        self.nearTownCells = nearTownCells
        self.list = nearTownCells.searchNear()
        locationManager.stopUpdatingLocation()
        activityIndicator.stopAnimating()
        mapTableView.reloadData()
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
