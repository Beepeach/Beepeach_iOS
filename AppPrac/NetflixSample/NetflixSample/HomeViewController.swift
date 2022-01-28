//
//  HomeViewController.swift
//  NetflixSample
//
//  Created by JunHeeJo on 11/25/21.
//

import UIKit
import SwiftUI

class HomeViewController: UICollectionViewController {
    // MARK: Properties
    var contents: [Content] = []
    var mainItem: Item?
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .black
        
        setConetentData()
        
        configureNavigationBar()
        configureCollectionView()
    }
    
    private func setConetentData() {
        contents = getContents()
        mainItem = contents.first?.contentItem.randomElement()
    }
    
    private func getContents() -> [Content] {
        guard let path = Bundle.main.path(forResource: "Content", ofType: "plist"),
              let data = FileManager.default.contents(atPath: path),
              let list = try? PropertyListDecoder().decode([Content].self, from: data) else {
                  return []
              }
        
        return list
        
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.hidesBarsOnSwipe = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "netflixIcon"), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .plain, target: nil, action: nil)
    }
    
    private func configureCollectionView() {
        collectionView.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: "ContentCollectionViewCell")
        collectionView.register(ContentHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ContentHeaderCollectionReusableView")
        collectionView.register(ContentRankCollectionViewCell.self, forCellWithReuseIdentifier: "ContentRankCollectionViewCell")
        collectionView.register(ContentMainCollectionViewCell.self, forCellWithReuseIdentifier: "ContentMainCollectionViewCell")
        collectionView.collectionViewLayout = getLayout()
    }
    
    private func getLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionNumber, enviroment -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            
            switch self.contents[sectionNumber].sectionType {
            case .basic:
                return self.createBasicTypeSection()
            case .large:
                return self.createLargeTypeSection()
            case .rank:
                return self.createRankTypeSection()
            case .main:
                return self.createMainTypeSection()
            }
            
        }
    }
    
    private func createBasicTypeSection() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(0.75))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 0, trailing: 5)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    private func createLargeTypeSection() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(0.75))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(400))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        sectionHeader.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        return section
    }
    
    private func createRankTypeSection() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(0.9))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        return section
    }
    
    private func createMainTypeSection() -> NSCollectionLayoutSection {
        // item
        let itemSize  = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(450))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
        
        return section
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        return sectionHeader
    }
}


// MARK: - UICollectionViewDataSource
extension HomeViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return contents.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return contents[section].contentItem.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch contents[indexPath.section].sectionType {
        case .basic, .large:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath) as? ContentCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.imageView.image = contents[indexPath.section].contentItem[indexPath.item].image
            return cell
        case .rank:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentRankCollectionViewCell", for: indexPath) as? ContentRankCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.imageView.image = contents[indexPath.section].contentItem[indexPath.item].image
            cell.rankLabel.text = String(describing: indexPath.item + 1)
            
            return cell
        case .main:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentMainCollectionViewCell", for: indexPath) as? ContentMainCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.imageView.image = mainItem?.image
            cell.descriptionLabel.text = mainItem?.description
            
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ContentHeaderCollectionReusableView", for: indexPath) as? ContentHeaderCollectionReusableView else {
                return  UICollectionReusableView()
            }
            
            headerView.sectionNameLabel.text = contents[indexPath.section].sectionName
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }
}


// MARK: - UICollectionViewDelegate
extension HomeViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionName = contents[indexPath.section].sectionName
        print("\(sectionName)의 \(indexPath.item + 1)번째 컨텐츠")
    }
}


// MARK: - SwiftUIPreview
struct HomeViewControllerPreView: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            let layout = UICollectionViewLayout()
            let homeViewController = HomeViewController(collectionViewLayout: layout)
            return UINavigationController(rootViewController: homeViewController)
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            
        }
        
        typealias UIViewControllerType = UIViewController
    }
}
