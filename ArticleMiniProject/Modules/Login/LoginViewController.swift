//
//  LoginViewController.swift
//  ArticleMiniProject
//
//  Created by faiq adi on 23/04/25.
//

import UIKit
import SnapKit
import RxSwift
import Auth0
import JWTDecode

class LoginViewController : LoginBuilder {
    
    private let disposeBag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UserDefaults.isAuthenticated ? goToHome() : observ()
        requestNotificationPermission()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func observ(){
        loginBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.loginAction()
        }).disposed(by: disposeBag)
    }
    
    private func loginAction(){
        Auth0Manager.shared.login()
        Auth0Manager.shared.credentialDataRelay.subscribe(onNext: { value in
            if (value.email != "") && (value.id != "") && !UserDefaults.isLogin && UserDefaults.isAuthenticated{
                UserDefaults.isLogin = true
                self.goToHome()
            } 
        }).disposed(by: disposeBag)
    }
    private func goToHome(){
        let vc = HomeViewController()
        vc.modalTransitionStyle = .flipHorizontal
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
