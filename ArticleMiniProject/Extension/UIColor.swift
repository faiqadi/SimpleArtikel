//
//  UIColor.swift
//  ArticleMiniProject
//
//  Created by faiq adi on 23/04/25.
//

import UIKit

enum Color: String, CaseIterable {
    // Broccoli
    case gray10
    case gray20
    case gray50
    case gray80
    
    case green5
    case green10
    case green20
    
    case purple10
    case purple20
    case purple30
    
    case white
}
extension UIColor {

    /// Initialize UIColor with predefined Color
    /// - Parameter color:  Predefined color
    convenience init(color: Color) {
        self.init(named: color.rawValue)!
    }

}
