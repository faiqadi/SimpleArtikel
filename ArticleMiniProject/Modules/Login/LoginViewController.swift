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
    private var credentialData = CredentialModel.empty
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        observ()
        UserDefaults.isAuthenticated ? goToHome() : print("loged out")
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
        Auth0.webAuth()
            .start { result in
                switch result {
                case .success(let credentials):
                    UserDefaults.isAuthenticated = true
                    
                    self.credentialData = CredentialModel.from(credentials.idToken)
                    
                    if self.credentialData.name != "" {
                        UserDefaults.username = self.credentialData.name
                    } else {
                        UserDefaults.username = self.credentialData.email
                    }
                    UserDefaults.token = credentials.accessToken
                    self.goToHome()
                case .failure(let error):
                    print("error = \(error)")
                }
            }
    }
    private func goToHome(){
        let vc = HomeViewController()
        vc.modalTransitionStyle = .flipHorizontal
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
