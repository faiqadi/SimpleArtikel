//
//  BaseViewController.swift
//  ArticleMiniProject
//
//  Created by faiq adi on 23/04/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import IQKeyboardManagerSwift
import Auth0

class BaseViewController: UIViewController {
    
    var viewWidth = 0.0
    var viewHeight = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(color: .white)
        viewWidth = view.frame.width
        viewHeight = view.frame.height
        configureKeyboard()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func configureKeyboard() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.resignOnTouchOutside = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.toolbarConfiguration.placeholderConfiguration.showPlaceholder = false
    }
    func getGreetingBasedOnLocalTime() -> String {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        switch hour {
        case 5..<12:
            return "Good morning"
        case 12..<17:
            return "Good afternoon"
        case 17..<22:
            return "Good evening"
        default:
            return "Good night"
        }
    }
    func logout(){
        Auth0.webAuth()
            .clearSession { result in
                switch result {
                case .success:
                    UserDefaults.isAuthenticated = false
                    let vc = LoginViewController()
                    vc.modalTransitionStyle = .flipHorizontal
                    self.navigationController?.pushViewController(vc, animated: true)
                case .failure:
                    print("")
                    UserDefaults.isAuthenticated = false
                }
            }
    }
}
