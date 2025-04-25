//
//  MoreViewController.swift
//  ArticleMiniProject
//
//  Created by faiq adi on 24/04/25.
//

import UIKit
import RxSwift

enum MorePageType {
    case Artikel
    case Blog
    case Reports
}

class MoreViewController: MoreBuilder {
    
    var pageType : MorePageType?
    private let disposeBag = DisposeBag()
    private var viewModel = MoreViewModel()
    
    private var presentDataList = [Article]()
    private var dataList = [Article]()
    private var searchDataList = [Article]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initiateApiCall()
        observeValue()
        searchSetup()
    }
    private func initiateApiCall(){
        switch pageType {
        case .Artikel:
            viewModel.getArtikelList(count: 30)
        case .Blog:
            viewModel.getBlogList(count: 30)
        case .Reports:
            viewModel.getReportList(count: 30)
        case nil:
            print("wrong page")
        }
    }
    //MARK: Listen Api call
    private func observeValue(){
      
        viewModel.listDataRelay
            .subscribe(onNext: {[weak self] event in
            guard let self else { return }
            switch event {
            case .loading:
                ProgressView.sharedInstance.showProgressView(self)
            case .next(let data):
                ProgressView.sharedInstance.hideProgressView()
                self.presentDataList = data ?? [Article]()
                self.dataList = self.presentDataList
                tableView.reloadData()
            case .error(let error):
                ProgressView.sharedInstance.hideProgressView()
            default:
                break
            }
        })
        .disposed(by: disposeBag)
        
        viewModel.searchDataRelay
            .subscribe(onNext: {[weak self] event in
            guard let self else { return }
            switch event {
            case .loading:
                ProgressView.sharedInstance.showProgressView(self)
            case .next(let data):
                ProgressView.sharedInstance.hideProgressView()
                self.presentDataList = data ?? [Article]()
                tableView.reloadData()
            case .error(let error):
                ProgressView.sharedInstance.hideProgressView()
            default:
                break
            }
        })
        .disposed(by: disposeBag)
    }
    //MARK: Configure Search Bar
    private func searchSetup(){
        
        searchBar.onSearch = { [weak self] searchText in
            print("Search for: \(searchText)")
            // Implement your search logic here
            if searchText == "" {
                self?.presentDataList = self?.dataList ?? [Article]()
            } else {
                self?.viewModel.searchArtikel(title: searchText, type: self?.pageType ?? .Artikel)
            }
            self?.tableView.reloadData()
        }
        
        searchBar.onSortOrderSelected = { [weak self] sortOrder in
            switch sortOrder {
            case .ascending:
                print("Sort by ascending order")
                // Implement ascending sort logic
                let sortData = self?.sortArticles(by: self?.presentDataList ?? [Article](), ascending: true)
                self?.presentDataList = sortData ?? [Article]()
                self?.tableView.reloadData()
            case .descending:
                print("Sort by descending order")
                // Implement descending sort logic
                let sortData = self?.sortArticles(by: self?.presentDataList ?? [Article](), ascending: false)
                self?.presentDataList = sortData ?? [Article]()
                self?.tableView.reloadData()
            }
        }
        
        searchBar.onFilterApplied = { [weak self] selectedFilters in
            print("Filters applied:")
            for (category, isSelected) in selectedFilters {
                print("\(category): \(isSelected)")
            }
            
            // Implement filter logic here
            // For example:
            let activeFilters = selectedFilters.filter { $0.value == true }.map { $0.key }
            print("Active filters: \(activeFilters)")
        }
    }
    // Function to sort articles by title
    func sortArticles(by articles: [Article], ascending: Bool) -> [Article] {
        return articles.sorted { (article1, article2) in
            if ascending {
                return article1.title ?? "" < article2.title ?? ""
            } else {
                return article1.title ?? "" > article2.title ?? ""
            }
        }
    }
}

//MARK: - Extension
extension MoreViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: TableView DataSource
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return presentDataList.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticlePreviewTableViewCell.reuseIdentifier, for: indexPath) as? ArticlePreviewTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(data: presentDataList[indexPath.row])
            
            
            return cell
        }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let articleDetailVC = ArticleDetailViewController()
        articleDetailVC.publishedAt = Date() // Ganti dengan tanggal yang sesuai
        articleDetailVC.titleLabel.text = dataList[indexPath.row].title
        articleDetailVC.summary = dataList[indexPath.row].summary
        articleDetailVC.previewImageUrl = dataList[indexPath.row].imageUrl // Ganti dengan URL gambar yang sesuai
        navigationController?.pushViewController(articleDetailVC, animated: true)
    }
        
    
}
