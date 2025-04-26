//
//  FilterPanel.swift
//  ArticleMiniProject
//
//  Created by faiq adi on 27/04/25.
//
import UIKit
import SnapKit

// MARK: - Filter Panel View
class FilterPanelView: UIView {
    // MARK: - UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Filter By Category"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        return stackView
    }()
    
    private let applyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Apply", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        return button
    }()
    
    // MARK: - Properties
    private var checkboxViews: [CheckboxView] = []
    private var filterOptions: [String] = []
    
    // MARK: - Closures for actions
    var onApplyFilters: (([String: Bool]) -> Void)?
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
        setupActions()
    }
    
    // MARK: - Public Methods
    func setupFilterOptions(options: [String]) {
        filterOptions = options
        
        // Remove existing checkboxes
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        checkboxViews = []
        
        // Add new checkboxes
        for option in options {
            let checkboxView = CheckboxView(title: option)
            stackView.addArrangedSubview(checkboxView)
            checkboxViews.append(checkboxView)
        }
    }
    
    // MARK: - Private Methods
    private func setupViews() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 8
        
        addSubview(titleLabel)
        addSubview(stackView)
        addSubview(applyButton)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        applyButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
    }
    
    private func setupActions() {
        applyButton.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
    }
    
    @objc private func applyButtonTapped() {
        var selectedFilters: [String: Bool] = [:]
        
        for (index, checkbox) in checkboxViews.enumerated() {
            selectedFilters[filterOptions[index]] = checkbox.isChecked
        }
        
        onApplyFilters?(selectedFilters)
    }
}
