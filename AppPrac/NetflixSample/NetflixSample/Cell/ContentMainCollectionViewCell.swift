//
//  ContentMainCollectionViewCell.swift
//  NetflixSample
//
//  Created by JunHeeJo on 11/25/21.
//

import UIKit

class ContentMainCollectionViewCell: UICollectionViewCell {
    // MARK: Properties
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
    
    // MARK: ViewLayout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureContentView()
    }
    
    private func configureContentView() {
        [baseStackView, menuStackView].forEach {
            contentView.addSubview($0)
        }
        
        configureBaseStackView()
        configureMenuStackView()
    }
    
    private func configureBaseStackView() {
        baseStackView.axis = .vertical
        baseStackView.alignment = .center
        baseStackView.distribution = .fillProportionally
        baseStackView.spacing = 5
        
        [imageView, descriptionLabel, contentStackView].forEach {
            baseStackView.addArrangedSubview($0)
        }
        
        configureImageViewInBaseStackView()
        configureDescriptionLabelInBaseStackView()
        configureContentStackViewInBaseStackView()
        
        baseStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
  
    private func configureImageViewInBaseStackView() {
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints {
            $0.width.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(imageView.snp.width)
        }
    }
    
    private func configureDescriptionLabelInBaseStackView() {
        descriptionLabel.font = .systemFont(ofSize: 13)
        descriptionLabel.textColor = .white
        descriptionLabel.sizeToFit()
    }
    
    private func configureContentStackViewInBaseStackView() {
        contentStackView.axis = .horizontal
        contentStackView.alignment = .center
        contentStackView.distribution = .equalCentering
        contentStackView.spacing = 20
        
        configurePlusButtonInContentStackView()
        configureInfoButtonInContentStackView()
        configurePlayButtonInContentStackView()
        
        [plusButton, playButton, infoButton].forEach {
            contentStackView.addArrangedSubview($0)
        }
        
        contentStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(60)
        }
    }
    
    private func configurePlusButtonInContentStackView() {
        plusButton.setTitle("내가 찜한 콘텐츠", for: .normal)
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusButton.addTarget(self, action: #selector(tapPlusButton(_:)), for: .touchUpInside)
        configureTitleAndTintColor(button: plusButton)
    }
    
    private func configureInfoButtonInContentStackView() {
        infoButton.setTitle("정보", for: .normal)
        infoButton.setImage(UIImage(systemName: "info.circle"), for: .normal)
        infoButton.addTarget(self, action: #selector(tapInfoButton(_:)), for: .touchUpInside)
        configureTitleAndTintColor(button: infoButton)
    }
    
    private func configureTitleAndTintColor(button: UIButton) {
        button.titleLabel?.font = .systemFont(ofSize: 13)
        button.setTitleColor(.white, for: .normal)
        button.imageView?.tintColor = .white
        button.adjustVerticalLayout(5)
    }

    private func configurePlayButtonInContentStackView() {
        playButton.setTitle("재생", for: .normal)
        playButton.setTitleColor(.black, for: .normal)
        playButton.backgroundColor = .white
        playButton.layer.cornerRadius = 3
        playButton.snp.makeConstraints {
            $0.width.equalTo(90)
            $0.height.equalTo(30)
        }
        playButton.addTarget(self, action: #selector(tapPlayButton(_:)), for: .touchUpInside)
    }

    private func configureMenuStackView() {
        menuStackView.axis = .horizontal
        menuStackView.alignment = .center
        menuStackView.distribution = .equalSpacing
        menuStackView.spacing = 20
        
        configureTVButtonInMenuStackView()
        configureMovieButtonInMenuStackView()
        configureCategoryButtonInMenuStackView()
        
        [tvButton, movieButton, categoryButton].forEach {
            menuStackView.addArrangedSubview($0)
        }
        
        menuStackView.snp.makeConstraints {
            $0.top.equalTo(baseStackView.snp.top)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
    }
    
    private func configureTVButtonInMenuStackView() {
        configureBalckShadowLayer(button: tvButton)
        tvButton.setTitle("TV 프로그램", for: .normal)
        tvButton.addTarget(self, action: #selector(tapTVButton(_:)), for: .touchUpInside)
    }
    
    private func configureMovieButtonInMenuStackView() {
        configureBalckShadowLayer(button: movieButton)
        movieButton.setTitle("영화", for: .normal)
        movieButton.addTarget(self, action: #selector(tapMovieButton(_:)), for: .touchUpInside)
    }
    
    private func configureCategoryButtonInMenuStackView() {
        configureBalckShadowLayer(button: categoryButton)
        categoryButton.setTitle("카테고리", for: .normal)
        categoryButton.addTarget(self, action: #selector(tapCategoryButton(_:)), for: .touchUpInside)
    }
    
    private func configureBalckShadowLayer(button: UIButton) {
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 3
    }
    
    // MARK : @objc func
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
