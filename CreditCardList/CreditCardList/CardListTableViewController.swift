//
//  CardListTableViewController.swift
//  CreditCardList
//
//  Created by JunHeeJo on 11/15/21.
//

import UIKit
import Kingfisher
import FirebaseDatabase

class CardListTableViewController: UITableViewController {
    // MARK: Properties
    var creditCardList: [CreditCard] = []
    var ref: DatabaseReference?
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "CardListTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "CardListTableViewCell")
        
        ref = Database.database().reference()
        ref?.observe(.value) { snapshot in
            guard let value = snapshot.value as? [String: [String: Any]] else { return
            }
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                let cardData = try JSONDecoder().decode([String: CreditCard].self, from: jsonData)
                let cardList = Array(cardData.values)
                self.creditCardList = cardList.sorted { $0.rank < $1.rank }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print("ERROR JSON Parsing \(error.localizedDescription)")
            }
        }
    }

    // MARK: - UITableViewDelegate, UITableView Datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return creditCardList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CardListTableViewCell", for: indexPath) as? CardListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.rankLabel.text = "\(creditCardList[indexPath.row].rank)위"
        cell.promotionLabel.text = "\(creditCardList[indexPath.row].promotionDetail.amount)만원 증정"
        cell.cardNameLabel.text = "\(creditCardList[indexPath.row].name)"
        
        let imageURL = URL(string: creditCardList[indexPath.row].cardImageURL)
        cell.cardImageView.kf.setImage(with: imageURL)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let cardDetailVC = storyboard.instantiateViewController(withIdentifier: "CardDetailViewContoller") as? CardDetailViewController else {
            return
        }
        
        cardDetailVC.promotionDetail = creditCardList[indexPath.row].promotionDetail
        self.navigationController?.pushViewController(cardDetailVC, animated: true)
        
        // Option1
         let cardID = creditCardList[indexPath.row].id
        // ref?.child("Item\(cardID)/isSelected").setValue(true)
        
        // Option2
        ref?.queryOrdered(byChild: "id").queryEqual(toValue: cardID).observe(.value) { [weak self] snapshot in
            guard let self = self,
                  let value = snapshot.value as? [String: [String: Any]],
                  let key = value.keys.first else { return }
            
            self.ref?.child("\(key)/isSelected").setValue(true)
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Option1
            let cardID = creditCardList[indexPath.row].id
            
            ref?.child("Item\(cardID)").removeValue()
            
            // Option2
            // ref.queryOrdered(byChild: "id").queryEqual(toValue: cardID).observe(.value) { [weak self] snapshot in
            //    guard let self = self,
            //         let value = snapshot.value as? [String: [String: Any]],
            //          let key = value.keys.first else { return }

            //    self.ref.child(key).removeValue()
            // }
        }
    }
}


