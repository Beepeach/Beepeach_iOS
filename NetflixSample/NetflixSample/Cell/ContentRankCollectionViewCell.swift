//
//  ContentRankCollectionViewCell.swift
//  NetflixSample
//
//  Created by JunHeeJo on 11/25/21.
//

import UIKit

class ContentRankCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    let rankLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureContentView()
        configureImageView()
        configureRankLabel()
    }
    
    private func configureContentView() {
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
    }
    
    private func configureImageView() {
        imageView.contentMode = .scaleToFill
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.8)
        }
    }
    
    private func configureRankLabel() {
        rankLabel.font = .systemFont(ofSize: 100, weight: .black)
        rankLabel.textColor = .white
        contentView.addSubview(rankLabel)
        rankLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().offset(25)
        }
    }
}
