//
//  HomeViewController.swift
//  ArticleMiniProject
//
//  Created by faiq adi on 23/04/25.
//

import UIKit
import RxSwift
import RxRelay

class HomeViewController : HomeBuilder {
    
    private let disposeBag = DisposeBag()
    private let viewModel = HomeViewModel()
    
    private var artikelDataList = [Article]()
    private var blogDataList = [Article]()
    private var reportDataList = [Article]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let greeting = getGreetingBasedOnLocalTime()
        greetingLabel.text = greeting
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        apiCall()
        observer()
    }
    
    private func configureCollectionView(){
        artikelCollectionView.delegate = self
        artikelCollectionView.dataSource = self
        blogCollectionView.delegate = self
        blogCollectionView.dataSource = self
        reportCollectionView.delegate = self
        reportCollectionView.dataSource = self
        
        artikelCollectionView.setCollectionViewLayout(collectionViewCreateLayout(), animated: true)
        blogCollectionView.setCollectionViewLayout(collectionViewCreateLayout(), animated: true)
        reportCollectionView.setCollectionViewLayout(collectionViewCreateLayout(), animated: true)
    }
    private func apiCall(){
        viewModel.getArtikelList(count: 8)
        viewModel.getBlogList(count: 8)
        viewModel.getReportList(count: 8)
        
    }
    private func observer(){
        artikelHeader.seeMoreBtn.rx.tap.subscribe(onNext: { [weak self] in
            let vc = MoreViewController()
            vc.pageType = .Artikel
            vc.modalTransitionStyle = .flipHorizontal
            self?.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
        
        blogHeader.seeMoreBtn.rx.tap.subscribe(onNext: { [weak self] in
            let vc = MoreViewController()
            vc.pageType = .Blog
            vc.modalTransitionStyle = .flipHorizontal
            self?.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
        
        reportHeader.seeMoreBtn.rx.tap.subscribe(onNext: { [weak self] in
            let vc = MoreViewController()
            vc.pageType = .Reports
            vc.modalTransitionStyle = .flipHorizontal
            self?.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
        
        //Listen Api call
        viewModel.listArtikelRelay
            .subscribe(onNext: {[weak self] event in
            guard let self else { return }
            switch event {
            case .loading:
                ProgressView.sharedInstance.showProgressView(self)
            case .next(let data):
                ProgressView.sharedInstance.hideProgressView()
                self.artikelDataList = data ?? [Article]()
                artikelCollectionView.reloadData()
            case .error(let error):
                ProgressView.sharedInstance.hideProgressView()
            default:
                break
            }
        })
        .disposed(by: disposeBag)
        
        viewModel.listBlogRelay
            .subscribe(onNext: {[weak self] event in
            guard let self else { return }
            switch event {
            case .loading:
                ProgressView.sharedInstance.showProgressView(self)
            case .next(let data):
                ProgressView.sharedInstance.hideProgressView()
                self.blogDataList = data ?? [Article]()
                blogCollectionView.reloadData()
            case .error(let error):
                ProgressView.sharedInstance.hideProgressView()
            default:
                break
            }
        })
        .disposed(by: disposeBag)
        
        viewModel.listReportRelay
        .subscribe(onNext: {[weak self] event in
        guard let self else { return }
        switch event {
        case .loading:
            ProgressView.sharedInstance.showProgressView(self)
        case .next(let data):
            ProgressView.sharedInstance.hideProgressView()
            self.reportDataList = data ?? [Article]()
            reportCollectionView.reloadData()
        case .error(let error):
            ProgressView.sharedInstance.hideProgressView()
        default:
            break
        }
    })
    .disposed(by: disposeBag)
    }
}

//MARK: CollectionView Setup
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case artikelCollectionView:
            return artikelDataList.count
        case blogCollectionView:
            return blogDataList.count
        case reportCollectionView:
            return reportDataList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case artikelCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentListCollectionViewCell.identifier, for: indexPath) as? ContentListCollectionViewCell else { fatalError("Unable to dequeue SubMenuCollectionViewCell") }
            cell.backgroundColor = UIColor(color: .gray10)
            cell.configureData(data: self.artikelDataList[indexPath.row])
            return cell
        case blogCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentListCollectionViewCell.identifier, for: indexPath) as? ContentListCollectionViewCell else { fatalError("Unable to dequeue SubMenuCollectionViewCell") }
            cell.backgroundColor = UIColor(color: .gray10)
            cell.configureData(data: self.blogDataList[indexPath.row])
            return cell
        case reportCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentListCollectionViewCell.identifier, for: indexPath) as? ContentListCollectionViewCell else { fatalError("Unable to dequeue SubMenuCollectionViewCell") }
            cell.backgroundColor = UIColor(color: .gray10)
            cell.configureData(data: self.reportDataList[indexPath.row])
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentListCollectionViewCell.identifier, for: indexPath) as? ContentListCollectionViewCell else { fatalError("Unable to dequeue SubMenuCollectionViewCell") }
            
            return cell
        }
    }
    
    
}
