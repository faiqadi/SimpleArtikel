//
//  UIView.swift
//  ArticleMiniProject
//
//  Created by faiq adi on 23/04/25.
//

import UIKit

extension UIView {
    
    
    func addBorder() {
        let borderOld = CALayer()
        
        let width = CGFloat(1.5)
        
        borderOld.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        borderOld.borderWidth = width
        
        self.layer.masksToBounds = true
        
        self.layer.addSublayer(borderOld)
    }
    
    func addBorder(color: UIColor){
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 1
    }
}
