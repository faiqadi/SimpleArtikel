//
//  Untitled.swift
//  ArticleMiniProject
//
//  Created by faiq adi on 23/04/25.
//

import UIKit
import SnapKit

class HomeBuilder: BaseViewController {
    
    var greetingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(color: .purple10)
        label.font = UIFont(.kappa, .regular)
        label.textAlignment = .center
        return label
    }()
    var userLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(color: .purple10)
        label.font = UIFont(.omicron, .regular)
        label.text = "Faiq"
        label.textAlignment = .center
        return label
    }()
    private lazy var contentContainer: UIStackView = {
        let stv = UIStackView()
        stv.axis = .vertical
        stv.spacing = 16
        stv.distribution = .fillProportionally

        stv.addArrangedSubview(artikelHeader)
        stv.addArrangedSubview(artikelCollectionView)
        stv.addArrangedSubview(blogHeader)
        stv.addArrangedSubview(blogCollectionView)
        stv.addArrangedSubview(reportHeader)
        stv.addArrangedSubview(reportCollectionView)

        return stv
    }()
    var artikelHeader: ContentHeader = {
        let header = ContentHeader()
        header.configureTitle(title: String.string(.artikel))
        header.snp.makeConstraints{ $0.height.equalTo(40) }
        return header
    }()
    var artikelCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.register(ContentListCollectionViewCell.self, forCellWithReuseIdentifier: "ContentListCollectionViewCell")
        collectionView.isScrollEnabled = true
        collectionView.snp.makeConstraints{ $0.height.equalTo(100) }
        
        return collectionView
    }()
    var blogHeader: ContentHeader = {
        let header = ContentHeader()
        header.configureTitle(title: String.string(.blog))
        header.snp.makeConstraints{ $0.height.equalTo(40) }
        return header
    }()
    var blogCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.isPagingEnabled = false
        collectionView.register(ContentListCollectionViewCell.self, forCellWithReuseIdentifier: "ContentListCollectionViewCell")
        collectionView.snp.makeConstraints{ $0.height.equalTo(100) }
        
        return collectionView
    }()
    var reportHeader: ContentHeader = {
        let header = ContentHeader()
        header.configureTitle(title: String.string(.report))
        header.snp.makeConstraints{ $0.height.equalTo(40) }
        return header
    }()
    var reportCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.isPagingEnabled = false
        collectionView.register(ContentListCollectionViewCell.self, forCellWithReuseIdentifier: "ContentListCollectionViewCell")
        collectionView.snp.makeConstraints{ $0.height.equalTo(100) }
        
        return collectionView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayoutPage()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func setupLayoutPage() {
        view.addSubview(greetingLabel)
        view.addSubview(userLabel)
        view.addSubview(contentContainer)
        
        greetingLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(32)
        }
        userLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(greetingLabel.snp.bottom).inset(-8)
        }
        contentContainer.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(userLabel.snp.bottom).inset(-32)
        }
        
    }
    
    func collectionViewCreateLayout() -> UICollectionViewCompositionalLayout {
        let layout =  UICollectionViewCompositionalLayout {[weak self] (sectionIndex, _) -> NSCollectionLayoutSection? in
            let section: NSCollectionLayoutSection
            
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .absolute(100),
                heightDimension: .absolute(100))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
            
            // Calculate width based on number of items
            let totalWidth = CGFloat(8) * 100
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .absolute(totalWidth),
                heightDimension: .absolute(100))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            section.orthogonalScrollingBehavior = .none
            
            return section
        }
        
        return layout
    }
}
