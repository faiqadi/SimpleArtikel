//
//  LabeledButtonView.swift
//  ArticleMiniProject
//
//  Created by faiq adi on 24/04/25.
//

import UIKit
import SnapKit

class ArticlePreviewView: UIView {
    
    // MARK: - UI Components
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray5
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    private let summaryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        label.numberOfLines = 3
        return label
    }()
    
    private let buttonsContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let launchesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("launches", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        return button
    }()
    
    private let eventButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("event", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        return button
    }()
    
    // MARK: - Properties
    var launchesButtonTapped: (() -> Void)?
    var eventButtonTapped: (() -> Void)?
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupConstraints()
        setupActions()
    }
    
    // MARK: - Setup
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(summaryLabel)
        addSubview(buttonsContainerView)
        
        buttonsContainerView.addSubview(launchesButton)
        buttonsContainerView.addSubview(eventButton)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(self.snp.width).multipliedBy(0.5) // Adjust the ratio as needed
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        summaryLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        buttonsContainerView.snp.makeConstraints { make in
            make.top.equalTo(summaryLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
        launchesButton.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.35)
        }
        
        eventButton.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.width.equalTo(launchesButton)
        }
    }
    
    private func setupActions() {
        launchesButton.addTarget(self, action: #selector(launchesButtonPressed), for: .touchUpInside)
        eventButton.addTarget(self, action: #selector(eventButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func launchesButtonPressed() {
        launchesButtonTapped?()
    }
    
    @objc private func eventButtonPressed() {
        eventButtonTapped?()
    }
    
    // MARK: - Public Methods
    func configure(with image: UIImage?, title: String, summary: String) {
        imageView.image = image
        titleLabel.text = title
        summaryLabel.text = summary
    }
    
    // Optional method to load image from URL
    func loadImage(from url: URL, completion: ((Bool) -> Void)? = nil) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion?(false)
                }
                return
            }
            
            DispatchQueue.main.async {
                self?.imageView.image = image
                completion?(true)
            }
        }.resume()
    }
}

// MARK: - Usage Example
//class ExampleViewController: UIViewController {
//    
//    private let articlePreview = ArticlePreviewView()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        
//        view.addSubview(articlePreview)
//        articlePreview.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//            make.leading.trailing.equalToSuperview().inset(20)
//        }
//        
//        // Configure the article preview
//        articlePreview.configure(
//            with: UIImage(named: "example_image"),
//            title: "This is an example article title that might be quite long",
//            summary: "This is a summary of the article. It provides a brief overview of what the article is about. The user can get a quick idea before deciding to read more."
//        )
//        
//        // Set up button actions
//        articlePreview.launchesButtonTapped = {
//            print("Launches button tapped")
//            // Add your action here
//        }
//        
//        articlePreview.eventButtonTapped = {
//            print("Event button tapped")
//            // Add your action here
//        }
//        
//        // Alternatively, load image from URL
//        // if let imageURL = URL(string: "https://example.com/image.jpg") {
//        //     articlePreview.loadImage(from: imageURL)
//        // }
//    }
//}
