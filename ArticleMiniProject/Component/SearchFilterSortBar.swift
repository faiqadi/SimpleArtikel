//
//  SearchFilterSortBar.swift
//  ArticleMiniProject
//
//  Created by faiq adi on 24/04/25.
//

import UIKit
import SnapKit

class SearchFilterSortBar: UIView {
    // MARK: - UI Elements
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.borderStyle = .none
        textField.backgroundColor = .clear
        textField.returnKeyType = .search
        textField.clearButtonMode = .whileEditing
        
        // Add search icon
        let searchIconView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        searchIconView.tintColor = .gray
        searchIconView.contentMode = .scaleAspectFit
        searchIconView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        searchIconView.center = leftView.center
        leftView.addSubview(searchIconView)
        textField.leftView = leftView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    private let filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Filter", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()
    
    private let sortButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sort", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()
    
    private let dividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        return view
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray6
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        return view
    }()
    
    // Filter panel elements
    private lazy var filterPanelView: FilterPanelView = {
        let view = FilterPanelView()
        view.isHidden = true
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 6
        view.layer.shadowOpacity = 0.15
        return view
    }()
    
    // MARK: - Properties
    private var isFilterPanelVisible = false
    
    // MARK: - Enums
    enum SortOrder {
        case ascending
        case descending
    }
    
    // MARK: - Closures for actions
    var onSearch: ((String) -> Void)?
    var onSortOrderSelected: ((SortOrder) -> Void)?
    var onFilterApplied: (([String: Bool]) -> Void)?
    
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
    func getSearchText() -> String {
        return searchTextField.text ?? ""
    }
    
    func setSearchText(_ text: String) {
        searchTextField.text = text
    }
    
    func setPlaceholder(_ text: String) {
        searchTextField.placeholder = text
    }
    
    func setFilterTitle(_ title: String) {
        filterButton.setTitle(title, for: .normal)
    }
    
    func setSortTitle(_ title: String) {
        sortButton.setTitle(title, for: .normal)
    }
    
    func setBarBackgroundColor(_ color: UIColor) {
        containerView.backgroundColor = color
    }
    
    func setButtonsColor(_ color: UIColor) {
        filterButton.tintColor = color
        sortButton.tintColor = color
    }
    
    func setupFilterOptions(options: [String]) {
        filterPanelView.setupFilterOptions(options: options)
    }
    
    // MARK: - Private Methods
    private func setupViews() {
        backgroundColor = .clear
        
        addSubview(containerView)
        containerView.addSubview(searchTextField)
        containerView.addSubview(filterButton)
        containerView.addSubview(dividerLine)
        containerView.addSubview(sortButton)
        addSubview(filterPanelView)
        
        // Set initial filter options for the example
        setupFilterOptions(options: ["Food", "Transportation", "Entertainment", "Shopping", "Bills"])
    }
    
    private func setupConstraints() {
        // Container constraints using SnapKit
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-8).priority(999)
            make.height.equalTo(44)
        }
        
        // Search text field constraints
        searchTextField.snp.makeConstraints { make in
            make.left.equalTo(containerView).offset(8)
            make.centerY.equalTo(containerView)
            make.height.equalTo(containerView).multipliedBy(0.9)
        }
        
        // Filter button constraints
        filterButton.snp.makeConstraints { make in
            make.left.greaterThanOrEqualTo(searchTextField.snp.right).offset(8)
            make.centerY.equalTo(containerView)
            make.width.equalTo(50)
        }
        
        // Divider line constraints
        dividerLine.snp.makeConstraints { make in
            make.left.equalTo(filterButton.snp.right)
            make.centerY.equalTo(containerView)
            make.width.equalTo(1)
            make.height.equalTo(containerView).multipliedBy(0.6)
        }
        
        // Sort button constraints
        sortButton.snp.makeConstraints { make in
            make.left.equalTo(dividerLine.snp.right)
            make.right.equalTo(containerView)
            make.centerY.equalTo(containerView)
            make.width.equalTo(50)
        }
        
        // Filter panel constraints
        filterPanelView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(4)
            make.left.equalTo(containerView)
            make.right.equalTo(containerView)
        }
    }
    
    private func setupActions() {
        searchTextField.delegate = self
        
        filterButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        sortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        
        // Set filter panel callback
        filterPanelView.onApplyFilters = { [weak self] selectedFilters in
            self?.toggleFilterPanel()
            self?.onFilterApplied?(selectedFilters)
        }
    }
    
    // MARK: - Actions
    @objc private func filterButtonTapped() {
        toggleFilterPanel()
    }
    
    private func toggleFilterPanel() {
        isFilterPanelVisible.toggle()
        
        UIView.animate(withDuration: 0.3) {
            self.filterPanelView.isHidden = !self.isFilterPanelVisible
            self.filterPanelView.alpha = self.isFilterPanelVisible ? 1.0 : 0.0
        }
    }
    
    @objc private func sortButtonTapped() {
        if #available(iOS 14.0, *) {
            showSortMenu_iOS14()
        } else {
            showSortActionSheet()
        }
    }
    
    // For iOS 14+ using UIMenu
    @available(iOS 14.0, *)
    private func showSortMenu_iOS14() {
        let ascendingAction = UIAction(title: "Ascending", image: UIImage(systemName: "arrow.up")) { [weak self] _ in
            self?.onSortOrderSelected?(.ascending)
        }
        
        let descendingAction = UIAction(title: "Descending", image: UIImage(systemName: "arrow.down")) { [weak self] _ in
            self?.onSortOrderSelected?(.descending)
        }
        
        let menu = UIMenu(title: "Sort Order", children: [ascendingAction, descendingAction])
        sortButton.menu = menu
        sortButton.showsMenuAsPrimaryAction = true
    }
    
    // For iOS 13 and below using UIAlertController
    private func showSortActionSheet() {
        guard let viewController = findViewController() else { return }
        
        let alertController = UIAlertController(title: "Sort Order", message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Ascending", style: .default) { [weak self] _ in
            self?.onSortOrderSelected?(.ascending)
        })
        
        alertController.addAction(UIAlertAction(title: "Descending", style: .default) { [weak self] _ in
            self?.onSortOrderSelected?(.descending)
        })
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // For iPad support
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = sortButton
            popoverController.sourceRect = sortButton.bounds
        }
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    private func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            responder = nextResponder
        }
        return nil
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !filterPanelView.isHidden {
            let convertedPoint = convert(point, to: filterPanelView)
            if filterPanelView.bounds.contains(convertedPoint) {
                return filterPanelView.hitTest(convertedPoint, with: event)
            }
        }
        return super.hitTest(point, with: event)
    }
}

// MARK: - UITextField Delegate
extension SearchFilterSortBar: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        onSearch?(textField.text ?? "")
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        onSearch?(textField.text ?? "")
    }
}

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
