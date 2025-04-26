//
//  CheckBox.swift
//  ArticleMiniProject
//
//  Created by faiq adi on 27/04/25.
//

import UIKit
import SnapKit

// MARK: - Checkbox View
class CheckboxView: UIView {
    // MARK: - UI Elements
    private let checkboxButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        button.tintColor = .systemBlue
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    // MARK: - Properties
    var isChecked: Bool {
        return checkboxButton.isSelected
    }
    
    // MARK: - Initialization
    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
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
    
    // MARK: - Private Methods
    private func setupViews() {
        addSubview(checkboxButton)
        addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        checkboxButton.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
            make.top.bottom.equalToSuperview().inset(4)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(checkboxButton.snp.right).offset(8)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    private func setupActions() {
        checkboxButton.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
        
        // Add tap gesture to the whole view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func checkboxTapped() {
        checkboxButton.isSelected.toggle()
    }
    
    @objc private func viewTapped() {
        checkboxButton.isSelected.toggle()
    }
}
