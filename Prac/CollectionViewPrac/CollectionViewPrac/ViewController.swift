//
//  ViewController.swift
//  CollectionViewPrac
//
//  Created by JunHeeJo on 11/1/21.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Properties
    let cellIdentifier: String = "cell"
    var friends: [Friend] = []
    
    // MARK: - @IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setFlowLayout()
        
        self.decodeFriends()
    }
    
    private func decodeFriends() {
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "friends") else {
            return
        }

        do {
            self.friends = try jsonDecoder.decode([Friend].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }

        self.collectionView.reloadData()
    }
}

// MARK: CustomFunctions
private func setFlowLayout() {
    let flowLayout: UICollectionViewFlowLayout
    flowLayout = UICollectionViewFlowLayout()
    flowLayout.sectionInset = UIEdgeInsets.zero
    flowLayout.minimumLineSpacing = 10
    flowLayout.minimumInteritemSpacing = 10
    
    let halfWidth: CGFloat = UIScreen.main.bounds.width / 2.0
    
    flowLayout.estimatedItemSize = CGSize(width: halfWidth - 30, height: 150)
}



// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.friends.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: CustomCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as? CustomCollectionViewCell else { return CustomCollectionViewCell() }
        
        let friend: Friend = friends[indexPath.item]
        
        cell.nameAgeLabel.text = friend.nameAndAge
        cell.adressLabel.text = friend.fullAddress
        
        return cell
    }
}


// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
    }
}
