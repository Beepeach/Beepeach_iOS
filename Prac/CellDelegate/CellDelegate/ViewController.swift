//
//  ViewController.swift
//  CellDelegate
//
//  Created by JunHeeJo on 2/16/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var listCollectionView: UICollectionView!
    @IBOutlet weak var secondTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listCollectionView.dataSource = self
    }
}


extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as? CustomCollectionViewCell else {
            return CustomCollectionViewCell()
        }
        
        cell.delegate = self
        
        return cell
    }
}


extension ViewController: CustomCollectionViewCellDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        secondTextField.becomeFirstResponder()
        return true
    }
}
