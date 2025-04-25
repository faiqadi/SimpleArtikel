//
//  UIButton.swift
//  ArticleMiniProject
//
//  Created by faiq adi on 23/04/25.
//

import UIKit

extension UIButton {
    func setPrimaryButton() {
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        self.clipsToBounds = true
        self.isUserInteractionEnabled = true
        self.setTitleColor(UIColor(color: .white), for: .normal)
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor(color: .green10).cgColor
        self.backgroundColor = UIColor(color: .green10)
    }
    func setSecondaryButton() {
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        self.clipsToBounds = true
        self.setTitleColor(UIColor(color: .gray20), for: .normal)
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor(color: .gray20).cgColor
        self.backgroundColor = UIColor(color: .white)
    }
    
    func setDisabledButton() {
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        self.clipsToBounds = true
        self.isUserInteractionEnabled = false
        self.setTitleColor(UIColor(color: .white), for: .normal)
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor(color: .gray50).cgColor
        self.backgroundColor = UIColor(color: .gray50)
    }
}
