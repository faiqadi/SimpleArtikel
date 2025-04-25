//
//  Common.swift
//  ArticleMiniProject
//
//  Created by faiq adi on 25/04/25.
//

import UIKit

class Common {
    
    static let shared = Common()
    
    /// Add subview to super window
    static var currentActiveWindow: UIWindow? {
        return UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }
    }
    
    /// Open settings from App
    func openDeviceSetting() {
        guard let url = URL(string: UIApplication.openSettingsURLString),
              UIApplication.shared.canOpenURL(url) else {
            assertionFailure("Not able to open App privacy settings")
            return
        }

        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
