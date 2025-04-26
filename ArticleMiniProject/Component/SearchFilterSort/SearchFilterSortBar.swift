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
    
    // Recent searches table view
    private lazy var recentSearchesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RecentSearchCell")
        tableView.backgroundColor = .systemBackground
        tableView.layer.cornerRadius = 8
        tableView.layer.shadowColor = UIColor.black.cgColor
        tableView.layer.shadowOffset = CGSize(width: 0, height: 2)
        tableView.layer.shadowRadius = 6
        tableView.layer.shadowOpacity = 0.15
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        tableView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: - Properties
    private var isFilterPanelVisible = false
    private var isRecentSearchesVisible = false
    private var recentSearches: [String] = UserDefaults.recentSearch
    
    // MARK: - Enums
    enum SortOrder {
        case ascending
        case descending
    }
    
    // MARK: - Closures for actions
    var onSearch: ((String) -> Void)?
    var onSortOrderSelected: ((SortOrder) -> Void)?
    var onFilterApplied: (([String: Bool]) -> Void)?
    var onRecentSearchSelected: ((String) -> Void)?
    
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
    
    func setRecentSearches(_ searches: [String]) {
        recentSearches = searches
        recentSearchesTableView.reloadData()
    }
    
    func addRecentSearch(_ search: String) {
        if !search.isEmpty && !recentSearches.contains(search) {
            recentSearches.insert(search, at: 0)
            
            // Limit the number of recent searches
            if recentSearches.count > 10 {
                recentSearches.removeLast()
            }
            
            recentSearchesTableView.reloadData()
        }
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
        addSubview(recentSearchesTableView)
        
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
        
        // Recent searches table view constraints
        recentSearchesTableView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(4)
            make.left.equalTo(containerView)
            make.right.equalTo(containerView)
            make.height.equalTo(200)
        }
    }
    
    private func setupActions() {
        searchTextField.delegate = self
        searchTextField.clearButtonMode = .always
        
        filterButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        sortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        
        // Add editing changed action for search text field
        searchTextField.addTarget(self, action: #selector(searchTextFieldEditingChanged), for: .editingChanged)
        
        // Set filter panel callback
        filterPanelView.onApplyFilters = { [weak self] selectedFilters in
            self?.toggleFilterPanel()
            self?.onFilterApplied?(selectedFilters)
        }
    }
    
    // MARK: - Actions
    @objc private func filterButtonTapped() {
        hideRecentSearches()
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
        hideRecentSearches()
        
        if #available(iOS 14.0, *) {
            showSortMenu_iOS14()
        } else {
            showSortActionSheet()
        }
    }
    
    @objc private func searchTextFieldEditingChanged() {
        // Show recent searches when typing starts
        showRecentSearches()
    }
    
    private func showRecentSearches() {
        if !isRecentSearchesVisible && recentSearches.count > 0 {
            isRecentSearchesVisible = true
            isFilterPanelVisible = false
            filterPanelView.isHidden = true
            
            recentSearchesTableView.isHidden = false
            recentSearchesTableView.alpha = 0
            
            UIView.animate(withDuration: 0.3) {
                self.recentSearchesTableView.alpha = 1.0
            }
        }
    }
    
    private func hideRecentSearches() {
        if isRecentSearchesVisible {
            isRecentSearchesVisible = false
            
            UIView.animate(withDuration: 0.3) {
                self.recentSearchesTableView.alpha = 0.0
            } completion: { _ in
                self.recentSearchesTableView.isHidden = true
            }
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
        // Check if point is in filter panel
        if !filterPanelView.isHidden {
            let convertedPoint = convert(point, to: filterPanelView)
            if filterPanelView.bounds.contains(convertedPoint) {
                return filterPanelView.hitTest(convertedPoint, with: event)
            }
        }
        
        // Check if point is in recent searches table view
        if !recentSearchesTableView.isHidden {
            let convertedPoint = convert(point, to: recentSearchesTableView)
            if recentSearchesTableView.bounds.contains(convertedPoint) {
                return recentSearchesTableView.hitTest(convertedPoint, with: event)
            }
            // If the touch is outside the table view, hide it
            hideRecentSearches()
        }
        
        return super.hitTest(point, with: event)
    }
}

// MARK: - UITextField Delegate
extension SearchFilterSortBar: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let searchText = textField.text ?? ""
        if !searchText.isEmpty {
            addRecentSearch(searchText)
        }
        onSearch?(searchText)
        hideRecentSearches()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let searchText = textField.text ?? ""
        if !searchText.isEmpty {
            addRecentSearch(searchText)
        }
        onSearch?(searchText)
        hideRecentSearches()
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        onSearch?("")
        hideRecentSearches()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if recentSearches.count > 0 {
            showRecentSearches()
        }
    }
}

// MARK: - TableView DataSource and Delegate
extension SearchFilterSortBar: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentSearches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecentSearchCell", for: indexPath)
        
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = recentSearches[indexPath.row]
            content.image = UIImage(systemName: "clock")
            content.imageProperties.tintColor = .systemGray
            cell.contentConfiguration = content
        } else {
            cell.textLabel?.text = recentSearches[indexPath.row]
            cell.imageView?.image = UIImage(systemName: "clock")
            cell.imageView?.tintColor = .systemGray
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedSearch = recentSearches[indexPath.row]
        setSearchText(selectedSearch)
        onRecentSearchSelected?(selectedSearch)
        onSearch?(selectedSearch)
        hideRecentSearches()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Recent Searches"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            recentSearches.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            if recentSearches.isEmpty {
                hideRecentSearches()
            }
        }
    }
}
