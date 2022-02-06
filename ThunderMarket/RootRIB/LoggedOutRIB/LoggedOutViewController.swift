//
//  LoggedOutViewController.swift
//  ThunderMarket
//
//  Created by 윤상진 on 2022/02/05.
//

import UIKit

import RIBs
import RxSwift
import RxCocoa
import SnapKit

protocol LoggedOutPresentableListener: AnyObject {
    func startLogin()
}

final class LoggedOutViewController: UIViewController, LoggedOutPresentable, LoggedOutViewControllable {

    weak var listener: LoggedOutPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildBackgroundView()
        buildLogoImageView()
        buildTitleLabel()
        buildStartButton()
    }
    
    private var logoImageView: UIImageView?
    private var titleLabel: UILabel?
    private var startButton: UIButton?
    
    private var disposeBag = DisposeBag()
    
    private func buildBackgroundView() {
        view.backgroundColor = .white
    }
    
    private func buildLogoImageView() {
        let logoImage = UIImage(named: "Logo.png")
        let logoImageView = UIImageView(image: logoImage)
        self.logoImageView = logoImageView
        
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(300)
        }
    }
    
    private func buildTitleLabel() {
        let titleLabel = UILabel()
        titleLabel.text = "당신 근처의 번개 마켓"
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        self.titleLabel = titleLabel
        
        view.addSubview(titleLabel)
        guard let logoImageView = logoImageView else {
            return
        }

        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoImageView.snp.bottom)
        }
    }
    
    private func buildStartButton() {
        let startButton = UIButton()
        startButton.backgroundColor = .systemYellow
        startButton.setTitle("시작하기", for: .normal)
        self.startButton = startButton
        
        view.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-30)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(50)
        }
        
        startButton.rx.tap.bind {
            self.listener?.startLogin()
        }
        .disposed(by: disposeBag)
    }
}
