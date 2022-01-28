//
//  BeerListTableViewCell.swift
//  Brewery
//
//  Created by JunHeeJo on 11/29/21.
//

import UIKit
import SnapKit
import Kingfisher

class BeerListTableViewCell: UITableViewCell {
    let beerImageView = UIImageView()
    let nameLabel = UILabel()
    let taglineLabel = UILabel()
    
    // awakeFromNib에서 하면 왜 안나올까?? layoutSubView와의 차이점 공부
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [beerImageView, nameLabel, taglineLabel].forEach {
            contentView.addSubview($0)
        }
        
        beerImageView.contentMode = .scaleAspectFit
        beerImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.top.bottom.equalToSuperview().inset(20)
            $0.width.equalTo(80)
            $0.height.equalTo(120)
        }
        
        nameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        nameLabel.numberOfLines = 2
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(beerImageView.snp.trailing).offset(10)
            $0.bottom.equalTo(beerImageView.snp.centerY)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        taglineLabel.font = .systemFont(ofSize: 14, weight: .light)
        taglineLabel.textColor = .systemBlue
        taglineLabel.numberOfLines = 0
        taglineLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(nameLabel)
            $0.top.equalTo(nameLabel.snp.bottom).inset(5)
        }
    }
    
    func configure(with beer: Beer) {
        let imageURL = URL(string: beer.imageURL ?? "")
        beerImageView.kf.setImage(with: imageURL, placeholder: UIImage(named: "beer_icon"))
        nameLabel.text = beer.name ?? "Unknown Beer"
        taglineLabel.text = beer.tagLine
        
        accessoryType = .disclosureIndicator
        selectionStyle = .none
    }
}
