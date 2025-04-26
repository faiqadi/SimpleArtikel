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
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(color: .white)
        viewWidth = view.frame.width
        viewHeight = view.frame.height
        configureKeyboard()
       
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleLogout),
                                               name: NSNotification.Name("userDidLogout"),
                                               object: nil)
        
        PersistentTimer.shared.isTimerCompleted.subscribe(onNext: { isNotAuthorized in
            if isNotAuthorized {
                DispatchQueue.main.async {
                     // execute your code
                    self.handleLogout()
                }
            }
        }).disposed(by: disposeBag)
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
    @objc func handleLogout() {
        // Navigate to login screen or update UI
        Auth0Manager.shared.logout()
        PersistentTimer.shared.cancelCountdown()
        UserDefaults.isLogin = false
        UserDefaults.isAuthenticated = false
        navigationController?.popToRootViewController(animated: true)
    }
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("Notification permission granted")
            } else if let error = error {
                print("Error requesting notification permissions: \(error)")
            }
        }
    }
}
