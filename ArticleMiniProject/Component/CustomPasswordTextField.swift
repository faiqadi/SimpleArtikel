//
//  CustomPasswordTextField.swift
//  ArticleMiniProject
//
//  Created by faiq adi on 23/04/25.
//

import PasswordTextField

class CustomPasswordTextField: PasswordTextField {

    fileprivate let idBtnTogglePassword = "btn_TogglePassword"
    fileprivate var myKvoContext: UInt8 = 0
    fileprivate var btnTogglePassword: SecureTextToggleButton!

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setup()

    }

    func setup() {
        

        self.btnTogglePassword = SecureTextToggleButton()
        self.btnTogglePassword.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        self.btnTogglePassword.imageTint = self.imageTintColor
        self.btnTogglePassword.hideSecureTextImage = UIImage(named: "ic_secure_off")!
        self.btnTogglePassword.showSecureTextImage = UIImage(named: "ic_secure_on")!
        self.btnTogglePassword.accessibilityIdentifier = idBtnTogglePassword
        
        let iconView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 24))
        iconView.addSubview(btnTogglePassword)
        self.rightView = iconView
        self.rightViewMode = .always

        self.btnTogglePassword.addObserver(self, forKeyPath: "isSecure", options: .new, context: &myKvoContext)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &myKvoContext {
            self.setSecureMode(self.btnTogglePassword.isSecure)
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }

    deinit {
        self.btnTogglePassword?.removeObserver(self, forKeyPath: "isSecure")
    }

}
