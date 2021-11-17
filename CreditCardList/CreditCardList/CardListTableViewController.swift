//
//  CardListTableViewController.swift
//  CreditCardList
//
//  Created by JunHeeJo on 11/15/21.
//

import UIKit
import Kingfisher
import FirebaseDatabase
import FirebaseFirestore

class CardListTableViewController: UITableViewController {
    // MARK: Properties
    var creditCardList: [CreditCard] = []
    var reference: DatabaseReference?
    var firestoreDB = Firestore.firestore()
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "CardListTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "CardListTableViewCell")
        
        fetchDataFrom(database: firestoreDB)
        // fetchDateFromReference()
    }
    
    // Firestore에서 데이터 읽어오기
    private func fetchDataFrom(database: Firestore) {
        database.collection("creditCardList").addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("ERROR Firestore fetching document \(error?.localizedDescription as Any)")
                return
            }
            
            self.creditCardList = documents.compactMap { doc -> CreditCard? in
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: doc.data(), options: [])
                    let creditCard = try JSONDecoder().decode(CreditCard.self, from: jsonData)
                    return creditCard
                } catch let error {
                    print("ERROR JSON Parsing \(error.localizedDescription)")
                    return nil
                }
            }.sorted { $0.rank < $1.rank }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // RealTimeDB에서 데이터 읽어오기
    private func fetchDateFromReference() {
        reference = Database.database().reference()
        reference?.observe(.value) { snapshot in
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
    
    
    // MARK: - UITableView Datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    
    // MARK: - UITableViewDelegate
    
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
        
        let cardID = creditCardList[indexPath.row].id
        
        updateDataToFirestoreWhenKnowPath(with: cardID)
        // updateDataToFirestoreWhenNotKnowPath(with: cardID)
        // updateDataToRealTimeDBWhenKnowPath(with: cardID)
        // updateDataToRealTimeDBWhenNotKnowPath(with: cardID)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let cardID = creditCardList[indexPath.row].id
            
            deleteDataToFirestoreWhenKnowPath(with: cardID)
            // deleteDataToFirestoreWhenNotKnowPath(with: cardID)
            // deleteDataToRealTimeDBWhenKnowPath(with: cardID)
            // deleteDataToRealTimeDBWhenNotKnowPath(with: cardID)
        }
    }
    
    
    private func updateDataToFirestoreWhenKnowPath(with cardID: Int) {
        // Option1(경로를 알고 있을때)
        firestoreDB.collection("creditCardList").document("card\(cardID)").updateData(["isSelected": true])
        
    }
    
    private func updateDataToFirestoreWhenNotKnowPath(with cardID: Int) {
        // Option2(경로를 모를때)
        firestoreDB.collection("creditCardList").whereField("id", isEqualTo: cardID).getDocuments { snapshot, _ in
            guard let document = snapshot?.documents.first else {
                print("ERROR Firesotre fetching document")
                return
            }
            
            document.reference.updateData(["isSelected" : true])
        }
    }
    
    private func updateDataToRealTimeDBWhenKnowPath(with cardID: Int) {
        // Option1(경로를 알고 있을때)
        reference?.child("Item\(cardID)/isSelected").setValue(true)
    }
    
    private func updateDataToRealTimeDBWhenNotKnowPath(with cardID: Int) {
        // Option2(경로를 모를때)
        reference?.queryOrdered(byChild: "id").queryEqual(toValue: cardID).observe(.value) { [weak self] snapshot in
            guard let self = self,
                  let value = snapshot.value as? [String: [String: Any]],
                  let key = value.keys.first else { return }
            
            self.reference?.child("\(key)/isSelected").setValue(true)
        }
    }
    
    private func deleteDataToFirestoreWhenKnowPath(with cardID: Int) {
        // Option1(경로를 알고 있을때)
        firestoreDB.collection("creditCardList").document("card\(cardID)").delete()
    }
    
    private func deleteDataToFirestoreWhenNotKnowPath(with cardID: Int) {
        // Option2(경로를 모를때)
        firestoreDB.collection("creditCardList").whereField("id", isEqualTo: cardID).getDocuments { snapshot, _ in
            guard let document = snapshot?.documents.first else {
                print("ERROR")
                return
            }
            
            document.reference.delete()
        }
    }
    
    private func deleteDataToRealTimeDBWhenKnowPath(with cardID: Int) {
        // Option1(경로를 알고 있을때)
        reference?.child("Item\(cardID)").removeValue()
    }
    
    private func deleteDataToRealTimeDBWhenNotKnowPath(with cardID: Int) {
        // Option2(경로를 모를때)
        reference?.queryOrdered(byChild: "id").queryEqual(toValue: cardID).observe(.value) { [weak self] snapshot in
            guard let self = self,
                  let value = snapshot.value as? [String: [String: Any]],
                  let key = value.keys.first else { return }
            
            self.reference?.child(key).removeValue()
        }
    }
}


