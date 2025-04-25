//
//  LoginViewController.swift
//  ArticleMiniProject
//
//  Created by faiq adi on 23/04/25.
//

import UIKit
import SnapKit
import RxSwift

class LoginViewController : LoginBuilder {
    
    private let disposeBag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        observ()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func observ(){
        loginBtn.rx.tap.subscribe(onNext: { [weak self] in
            let vc = HomeViewController()
            vc.modalTransitionStyle = .flipHorizontal
            self?.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
    }
}
