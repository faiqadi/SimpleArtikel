//
//  CellView.swift
//  ArticleMiniProject
//
//  Created by faiq adi on 23/04/25.
//

import UIKit

extension UICollectionViewCell {
   static var identifier: String {
        return String(describing: self)
    }

    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
