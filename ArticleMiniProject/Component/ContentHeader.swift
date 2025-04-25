//
//  ContentHeader.swift
//  ArticleMiniProject
//
//  Created by faiq adi on 23/04/25.
//

import UIKit
import SnapKit

class ContentHeader: UIView {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(color: .purple10)
        label.font = UIFont(.omicron, .bold)
        return label
    }()
    var seeMoreBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle(String.string(.seeMore), for: .normal)
        btn.backgroundColor = UIColor(color: .purple10)
        btn.isUserInteractionEnabled = true
        return btn
    }()
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(titleLabel)
        self.addSubview(seeMoreBtn)
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalTo(self.snp.bottom)
        }
        seeMoreBtn.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalTo(self.snp.bottom)
        }
        
    }
    func configureTitle(title: String){
        titleLabel.text = title
    }
    
}
