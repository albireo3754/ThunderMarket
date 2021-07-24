//
//  FindAddressViewController.swift
//  ThunderMarket
//
//  Created by 윤상진 on 2021/07/18.
//

import UIKit

class FindAddressViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    var isLoading = false
    
    @IBOutlet weak var mapTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(nearTownCells)
        return nearTownCells.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NearTownCell", for: indexPath)
        cell.textLabel?.text = String(nearTownCells.list[indexPath.row])
//        print(nearTownCells.list[indexPath.row])
        return cell
    }
    
    let nearTownCells = Town()

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.delegate = self
        print(3)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print(4)
    }
    
    @IBAction func popView(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "근처 동네"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: - ScrollView
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPosition = scrollView.contentOffset.y
        // TODO: - frame이 뭔데?
        let y = mapTableView.contentSize.height - scrollView.frame.height
        print(scrollPosition, y)
        if y == scrollPosition {
            print("Y!")
            self.nearTownCells.append()
            mapTableView.reloadData()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
