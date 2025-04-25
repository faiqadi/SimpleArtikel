//
//  ProgressView.swift
//  ArticleMiniProject
//
//  Created by faiq adi on 25/04/25.
//

import UIKit
import GIFImageView

class ProgressView {
    
    var contentView = UIView()
    private var loadingView = UIView()
    private var imgvLoading = UIImageView()
    private var lblPleaseWait = UILabel()
    private let loadingImage = UIImage.animatedImage(named: "Loading")
    
    init() {
        // Init contentView
        contentView.backgroundColor = UIColor(white: 0x000000, alpha: 0.5)
        contentView.translatesAutoresizingMaskIntoConstraints = false

        // Init loadingView
        loadingView.frame = CGRect()
        loadingView.center = contentView.center
        loadingView.backgroundColor = .white
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 6
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        loadingView.heightAnchor.constraint(equalToConstant: 142).isActive = true

        // Init imgvLoading
        imgvLoading.frame = CGRect()
        imgvLoading.image = loadingImage
        imgvLoading.translatesAutoresizingMaskIntoConstraints = false

        // Init lblPleaseWait
        lblPleaseWait.text = "Silakan tunggu..."
        lblPleaseWait.font = UIFont(.omega, .regular)
        lblPleaseWait.textAlignment = .center
        lblPleaseWait.translatesAutoresizingMaskIntoConstraints = false
        lblPleaseWait.heightAnchor.constraint(equalToConstant: 12).isActive = true

        loadingView.addSubview(imgvLoading)
        loadingView.addSubview(lblPleaseWait)

        contentView.addSubview(loadingView)
    }
    
    open class var sharedInstance: ProgressView {
        struct Static {
            static let instance: ProgressView = ProgressView()
        }
        return Static.instance
    }
    
    open func showProgressView(_ vc: UIViewController) {
        if let navVC = vc.parent?.navigationController {
            navVC.view.addSubview(contentView)
        } else {
            vc.view.addSubview(contentView)
        }

        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: vc.view.topAnchor),
            vc.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vc.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            loadingView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            imgvLoading.topAnchor.constraint(equalTo: loadingView.topAnchor, constant: 8),
            imgvLoading.leadingAnchor.constraint(equalTo: loadingView.leadingAnchor, constant: 8),
            loadingView.trailingAnchor.constraint(equalTo: imgvLoading.trailingAnchor, constant: 8),

            lblPleaseWait.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            lblPleaseWait.topAnchor.constraint(equalTo: imgvLoading.bottomAnchor, constant: 4),
            loadingView.bottomAnchor.constraint(equalTo: lblPleaseWait.bottomAnchor, constant: 8)
        ])
    }
    
    open func showProgressViewWindow() {
        if let window = Common.currentActiveWindow {
            window.addSubview(contentView)
            NSLayoutConstraint.activate([
                contentView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
                contentView.topAnchor.constraint(equalTo: window.topAnchor),
                window.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                window.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

                loadingView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                loadingView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

                imgvLoading.topAnchor.constraint(equalTo: loadingView.topAnchor, constant: 8),
                imgvLoading.leadingAnchor.constraint(equalTo: loadingView.leadingAnchor, constant: 8),
                loadingView.trailingAnchor.constraint(equalTo: imgvLoading.trailingAnchor, constant: 8),

                lblPleaseWait.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
                lblPleaseWait.topAnchor.constraint(equalTo: imgvLoading.bottomAnchor, constant: 4),
                loadingView.bottomAnchor.constraint(equalTo: lblPleaseWait.bottomAnchor, constant: 8)
            ])
        }
    }
    
    open func hideProgressView() {
        contentView.removeFromSuperview()
    }

    @available(*, deprecated, message: "No isProgressViewAnimating in new loading view")
    open func isProgressViewAnimating() -> Bool {
        return false
    }
}
