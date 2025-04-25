//
//  UIFont.swift
//  ArticleMiniProject
//
//  Created by faiq adi on 23/04/25.
//

import UIKit
/// Define custom font family(s) here
enum FontFamily: String {
    case nunitoSans = "NunitoSans"

    static let defaultFamily = FontFamily.nunitoSans
    var name: String { self.rawValue }
}

enum FontSize: CGFloat {
    /// Font size 72px
    case alpha = 72.0
    /// Font size 60px
    case beta = 60.0
    /// Font size 48px
    case gamma = 48.0
    /// Font size 36px
    case delta = 36.0
    /// Font size 30px
    case epsilon = 30.0
    /// Font size 24px
    case zeta = 24.0
    /// Font size 20px
    case kappa = 20.0
    /// Font size 18px
    case lambda = 18.0
    /// Font size 16px
    case omicron = 16.0
    /// Font size 14px
    case sigma = 14.0
    /// Font size 12px
    case omega = 12.0
    /// Font size 10px
    case atom = 10.0

    /// Return font size in CGFloat
    var point: CGFloat {
        self.rawValue
    }
}
enum FontWeight: String {
    /// SemiBold
    case regular = "SemiBold"
    /// ExtraBold
    case bold = "ExtraBold"
    /// SemiBoldItalic
    case italic = "SemiBoldItalic"
    /// ExtraBoldItalic
    case italicBold = "ExtraBoldItalic"
}
extension UIFont {
    private class func stringName(_ family: FontFamily, _ weight: FontWeight) -> String {
        let fontWeight: String

        switch (family, weight) {
        case (.nunitoSans, .regular):
            fontWeight = FontWeight.regular.rawValue
        case (.nunitoSans, .bold):
            fontWeight = FontWeight.bold.rawValue
        case (.nunitoSans, .italic):
            fontWeight = FontWeight.italic.rawValue
        case (.nunitoSans, .italicBold):
            fontWeight = FontWeight.italicBold.rawValue

        default:
            fontWeight = weight.rawValue
        }

        let familyName = family.name
        return fontWeight.isEmpty ? "\(familyName)" : "\(familyName)-\(fontWeight)"
    }
    
    /// Initialize UIFont with default font family
    /// - Parameters:
    ///   - size: FontSize ex: alpha, beta
    ///   - weight: FontWeight ex: regular, bold, italic, italicBold
    convenience init?(_ size: FontSize, _ weight: FontWeight) {
        self.init(.defaultFamily, size, weight)
    }

    /// Initializze UIFont with font family as parameter
    /// - Parameters:
    ///   - family: FontFamily
    ///   - size: FontSize
    ///   - weight: FontWeight
    convenience init?(_ family: FontFamily = .defaultFamily,
                     _ size: FontSize, _ weight: FontWeight) {
        self.init(name: UIFont.stringName(family, weight), size: size.point)
    }
    
}
