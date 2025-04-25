//
//  ContentListCollectionViewCell.swift
//  ArticleMiniProject
//
//  Created by faiq adi on 23/04/25.
//

import UIKit
import SnapKit
import Kingfisher

class ContentListCollectionViewCell: UICollectionViewCell {
    // MARK: - UI PROPERTIES
    private var imageContent : UIImageView = {
        let image = UIImageView()
        return image
    }()
    private var titleContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(color: .gray10)
        view.alpha = 0.8
        return view
    }()
    private var titleContent : UILabel = {
        let label = UILabel()
        label.textColor = UIColor(color: .gray80)
        label.font = UIFont(.omega, .regular)
        label.text = "Content"
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - CONFIGURE
    private func configureView() {
        
        addSubview(imageContent)
        addSubview(titleContainer)
        addSubview(titleContent)
        imageContent.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        titleContainer.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(40)
        }
        titleContent.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(4)
            make.centerY.equalTo(titleContainer.snp.centerY)
        }
    }
    
    func configureData(data: Article){
        titleContent.text = data.title
        imageContent.kf.setImage(with: URL(string: data.imageUrl ?? ""))
    }
}
