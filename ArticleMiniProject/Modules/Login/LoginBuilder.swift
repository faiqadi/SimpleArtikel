//
//  LoginBuilder.swift
//  ArticleMiniProject
//
//  Created by faiq adi on 23/04/25.
//

import UIKit
import SnapKit

class LoginBuilder: BaseViewController {
    
    var mainContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(color: .white)
        return view
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(color: .purple10)
        label.font = UIFont(.gamma, .bold)
        label.text = "My Article"
        label.textAlignment = .center
        return label
    }()
    var titleCaption: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(color: .purple10)
        label.font = UIFont(.omega, .regular)
        label.text = "get your newest article"
        label.textAlignment = .center
        return label
    }()
    
    
    var usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(color: .gray80)
        label.text = String.string(.email)
        label.font = UIFont(.sigma, .regular)
        return label
    }()
    
    var usernameField: UITextField = {
        let field = UITextField()
        field.addBorder()
        field.layer.cornerRadius = 6
        field.addBorder(color: UIColor(color: .gray50))
        field.placeholder = String.string(.inputEmail)
        field.setLeftPaddingPoints(16)
        field.setRightPaddingPoints(16)
        field.snp.makeConstraints{ $0.height.equalTo(48) }
        return field
    }()
    
    var passwordLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(color: .gray80)
        label.text = String.string(.password)
        label.font = UIFont(.sigma, .regular)
        return label
    }()
    var passwordField: CustomPasswordTextField = {
        let field = CustomPasswordTextField()
        field.addBorder()
        field.layer.cornerRadius = 6
        field.addBorder(color: UIColor(color: .gray50))
        field.placeholder = String.string(.inpurPassword)
        field.setLeftPaddingPoints(16)
        field.snp.makeConstraints{ $0.height.equalTo(48) }
        field.autocorrectionType = .no
        field.isSecureTextEntry = true
        field.showButtonWhile = .Always
        return field
    }()
    var loginBtn : UIButton = {
        let button = UIButton()
        button.setSecondaryButton()
        button.snp.makeConstraints{ $0.height.equalTo(40) }
        button.setTitle(String.string(.login), for: .normal)
        return button
    }()
    var registBtn : UIButton = {
        let button = UIButton()
        button.setPrimaryButton()
        button.snp.makeConstraints{ $0.height.equalTo(40) }
        button.setTitle(String.string(.signUp), for: .normal)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayoutPage()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    func setupLayoutPage(){
        
        view.addSubview(mainContainer)
        view.addSubview(titleLabel)
        view.addSubview(titleCaption)
        view.addSubview(usernameLabel)
        view.addSubview(usernameField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordField)
        view.addSubview(loginBtn)
        view.addSubview(registBtn)
        
        mainContainer.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(64)
            make.left.right.equalToSuperview().inset(32)
        }
        titleCaption.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalTo(titleLabel.snp.centerX)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.top.equalTo(titleCaption.snp.bottom).inset(-32)
        }
        usernameField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(usernameLabel.snp.bottom).inset(-8)
        }
        passwordLabel.snp.makeConstraints { make in
            make.left.equalTo(usernameLabel.snp.left)
            make.top.equalTo(usernameField.snp.bottom).inset(-16)
        }
        passwordField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(passwordLabel.snp.bottom).inset(-8)
        }
        
        registBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(32)
            make.left.right.equalToSuperview().inset(64)
        }
        loginBtn.snp.makeConstraints { make in
            make.bottom.equalTo(registBtn.snp.top).inset(-16)
            make.left.right.equalToSuperview().inset(64)
        }
    }
}
