//
//  ContentMainCollectionViewCell.swift
//  NetflixSample
//
//  Created by JunHeeJo on 11/25/21.
//

import UIKit

class ContentMainCollectionViewCell: UICollectionViewCell {
    let baseStackView = UIStackView()
    let menuStackView = UIStackView()
    
    let imageView = UIImageView()
    let descriptionLabel = UILabel()
    let contentStackView = UIStackView()
    
    let plusButton = UIButton()
    let playButton = UIButton()
    let infoButton = UIButton()
    
    let tvButton = UIButton()
    let movieButton = UIButton()
    let categoryButton = UIButton()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [baseStackView, menuStackView].forEach {
            contentView.addSubview($0)
        }
        
        // baseStackView
        baseStackView.axis = .vertical
        baseStackView.alignment = .center
        baseStackView.distribution = .fillProportionally
        baseStackView.spacing = 5
        
        [imageView, descriptionLabel, contentStackView].forEach {
            baseStackView.addArrangedSubview($0)
        }
        
        // imageView
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints {
            $0.width.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(imageView.snp.width)
        }
        
        // DescriptionLabel
        descriptionLabel.font = .systemFont(ofSize: 13)
        descriptionLabel.textColor = .white
        descriptionLabel.sizeToFit()
        
        // ContentStackView
        contentStackView.axis = .horizontal
        contentStackView.alignment = .center
        contentStackView.distribution = .equalCentering
        contentStackView.spacing = 20
        
        //
        [plusButton, infoButton].forEach {
            contentStackView.addArrangedSubview($0)
            $0.titleLabel?.font = .systemFont(ofSize: 13)
            $0.setTitleColor(.white, for: .normal)
            $0.imageView?.tintColor = .white
            $0.adjustVerticalLayout(5)
        }
        
        plusButton.setTitle("내가 찜한 콘텐츠", for: .normal)
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusButton.addTarget(self, action: #selector(tapPlusButton(_:)), for: .touchUpInside)
        
        infoButton.setTitle("정보", for: .normal)
        infoButton.setImage(UIImage(systemName: "info.circle"), for: .normal)
        infoButton.addTarget(self, action: #selector(tapInfoButton(_:)), for: .touchUpInside)
        
        contentStackView.addArrangedSubview(playButton)
        playButton.setTitle("재생", for: .normal)
        playButton.setTitleColor(.black, for: .normal)
        playButton.backgroundColor = .white
        playButton.layer.cornerRadius = 3
        playButton.snp.makeConstraints {
            $0.width.equalTo(90)
            $0.height.equalTo(30)
        }
        playButton.addTarget(self, action: #selector(tapPlayButton(_:)), for: .touchUpInside)
        
        
        
        contentStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        baseStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // meunStackView
        menuStackView.axis = .horizontal
        menuStackView.alignment = .center
        menuStackView.distribution = .equalSpacing
        menuStackView.spacing = 20
        
        [tvButton, movieButton, categoryButton].forEach {
            menuStackView.addArrangedSubview($0)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOpacity = 1
            $0.layer.shadowRadius = 3
        }
        
        tvButton.setTitle("TV 프로그램", for: .normal)
        movieButton.setTitle("영화", for: .normal)
        categoryButton.setTitle("카테고리", for: .normal)
        
        tvButton.addTarget(self, action: #selector(tapTVButton(_:)), for: .touchUpInside)
        movieButton.addTarget(self, action: #selector(tapMovieButton(_:)), for: .touchUpInside)
        categoryButton.addTarget(self, action: #selector(tapCategoryButton(_:)), for: .touchUpInside)
        
        menuStackView.snp.makeConstraints {
            $0.top.equalTo(baseStackView.snp.top)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
    }
    
    @objc func tapTVButton(_ sender: UIButton) {
        print("TEST: TV Button Tapped")
    }
    
    @objc func tapMovieButton(_ sender: UIButton) {
       print("TEST: Movie Button Tapped")
    }
    
    @objc func tapCategoryButton(_ sender: UIButton) {
        print("TEST: Category Button Tapped")
    }
    
    @objc func tapPlusButton(_ sender: UIButton) {
        print("TEST: Plus Button Tapped")
    }
    
    @objc func tapInfoButton(_ sender: UIButton) {
        print("TEST: Info Button Tapped")
    }
    
    @objc func tapPlayButton(_ sender: UIButton) {
        print("TEST: Play Button Tapped")
    }
}
