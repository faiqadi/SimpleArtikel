//
//  DetailViewController.swift
//  ArticleMiniProject
//
//  Created by faiq adi on 24/04/25.
//

import UIKit
import SnapKit

class ArticleDetailViewController: UIViewController {
    
    // MARK: - Properties
    var publishedAt: Date?
    var summary: String?
    var previewImageUrl: String?
    
    // MARK: - UI Elements
    private let previewImageView = UIImageView()
    private let publishedAtLabel = UILabel()
    private let summaryLabel = UILabel()
    var backBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("<-", for: .normal)
        btn.titleLabel?.font = UIFont(.lambda, .bold)
        btn.setTitleColor(UIColor(color: .purple10), for: .normal)
        return btn
    }()
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(color: .gray80)
        label.font = UIFont(.omicron, .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureData()
        backBtn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(backBtn)
        // Setup Preview Image
        previewImageView.contentMode = .scaleAspectFill
        previewImageView.clipsToBounds = true
        view.addSubview(previewImageView)
        
        // Setup Published At Label
        publishedAtLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        publishedAtLabel.textColor = .darkGray
        view.addSubview(publishedAtLabel)
        
        // Setup Summary Label
        summaryLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        summaryLabel.textColor = .black
        summaryLabel.numberOfLines = 0
        view.addSubview(summaryLabel)
        view.addSubview(titleLabel)
        
        // Layout with SnapKit
        backBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(8)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(8)
            make.width.equalTo(40)
        }
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(backBtn.snp.right).inset(8)
            make.right.equalToSuperview().inset(16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(18)
        }
        
        previewImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(200)
        }
        
        publishedAtLabel.snp.makeConstraints { make in
            make.top.equalTo(previewImageView.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
        }
        
        summaryLabel.snp.makeConstraints { make in
            make.top.equalTo(publishedAtLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
        }
    }
    @objc func backAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Configure Data
    private func configureData() {
        if let publishedAt = publishedAt {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .short
            dateFormatter.locale = Locale(identifier: "id_ID") // Set locale to Indonesian
            publishedAtLabel.text = dateFormatter.string(from: publishedAt)
        }
        
        if let summary = summary {
            let firstSentence = summary.components(separatedBy: ".").first ?? ""
            summaryLabel.text = firstSentence.trimmingCharacters(in: .whitespaces)
        }
        
        if let previewImageUrl = previewImageUrl, let url = URL(string: previewImageUrl) {
            // Load image asynchronously
            loadImage(from: url)
        }
    }
    
    // MARK: - Load Image
    private func loadImage(from url: URL) {
        // Simple image loading using URLSession
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.previewImageView.image = UIImage(data: data)
            }
        }.resume()
    }
}
