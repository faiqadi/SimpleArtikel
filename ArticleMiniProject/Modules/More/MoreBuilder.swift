//
//  MoreBuilder.swift
//  ArticleMiniProject
//
//  Created by faiq adi on 24/04/25.
//

import UIKit
import SnapKit

class MoreBuilder: BaseViewController {
    var backBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("<-", for: .normal)
        btn.titleLabel?.font = UIFont(.lambda, .bold)
        btn.setTitleColor(UIColor(color: .purple10), for: .normal)
        return btn
    }()
    var pageLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(color: .purple10)
        label.font = UIFont(.kappa, .bold)
        label.text = "Artikel"
        label.textAlignment = .center
        return label
    }()
    
    let searchBar: SearchFilterSortBar = {
        let bar = SearchFilterSortBar()
        return bar
    }()
    
    var tableView: UITableView = {
        let table = UITableView()
        table.register(ArticlePreviewTableViewCell.self, forCellReuseIdentifier: ArticlePreviewTableViewCell.reuseIdentifier)
        table.separatorStyle = .none
        table.backgroundColor = .systemGroupedBackground
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 300
        // Add some padding at the top and bottom
        table.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayoutPage()
        backBtn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private func setupLayoutPage(){
        view.addSubview(backBtn)
        view.addSubview(pageLabel)
        view.addSubview(tableView)
        view.addSubview(searchBar)
        
        backBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(8)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(8)
            make.width.equalTo(40)
        }
        pageLabel.snp.makeConstraints { make in
            make.left.equalTo(backBtn.snp.right).inset(-16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(16)
        }
        searchBar.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(pageLabel.snp.bottom).inset(-16)
            make.height.equalTo(60)
        }
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom).inset(-16)
        }
    }
    @objc func backAction(){
        self.navigationController?.popViewController(animated: true)
    }
}
