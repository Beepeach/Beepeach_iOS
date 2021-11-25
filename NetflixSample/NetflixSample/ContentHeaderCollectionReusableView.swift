//
//  ContentHeaderCollectionReusableView.swift
//  NetflixSample
//
//  Created by JunHeeJo on 11/25/21.
//

import UIKit

class ContentHeaderCollectionReusableView: UICollectionReusableView {
    let sectionNameLabel: UILabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        sectionNameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        sectionNameLabel.textColor = .white
        sectionNameLabel.sizeToFit()
        
        addSubview(sectionNameLabel)
        
        sectionNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.bottom.leading.equalToSuperview().offset(10)
        }
    }
}
