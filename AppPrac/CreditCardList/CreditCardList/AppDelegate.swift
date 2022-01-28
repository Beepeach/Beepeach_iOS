//
//  AppDelegate.swift
//  CreditCardList
//
//  Created by JunHeeJo on 11/15/21.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Firebase 초기화
        FirebaseApp.configure()
        
        // Batch Data
        let db = Firestore.firestore()
        batchCardDate(database: db)
        
        return true
    }
    
    private func batchCardDate(database: Firestore) {
        database.collection("creditCardList").getDocuments { snapshot, _ in
            guard snapshot?.isEmpty == true else { return }
            let batch = database.batch()
            
            let card0Reference = database.collection("creditCardList").document("card0")
            let card1Reference = database.collection("creditCardList").document("card1")
            let card2Reference = database.collection("creditCardList").document("card2")
            let card3Reference = database.collection("creditCardList").document("card3")
            let card4Reference = database.collection("creditCardList").document("card4")
            let card5Reference = database.collection("creditCardList").document("card5")
            let card6Reference = database.collection("creditCardList").document("card6")
            let card7Reference = database.collection("creditCardList").document("card7")
            let card8Reference = database.collection("creditCardList").document("card8")
            let card9Reference = database.collection("creditCardList").document("card9")
            
            do {
                try batch.setData(from: CreditCardDummy.card0, forDocument: card0Reference)
                try batch.setData(from: CreditCardDummy.card1, forDocument: card1Reference)
                try batch.setData(from: CreditCardDummy.card2, forDocument: card2Reference)
                try batch.setData(from: CreditCardDummy.card3, forDocument: card3Reference)
                try batch.setData(from: CreditCardDummy.card4, forDocument: card4Reference)
                try batch.setData(from: CreditCardDummy.card5, forDocument: card5Reference)
                try batch.setData(from: CreditCardDummy.card6, forDocument: card6Reference)
                try batch.setData(from: CreditCardDummy.card7, forDocument: card7Reference)
                try batch.setData(from: CreditCardDummy.card8, forDocument: card8Reference)
                try batch.setData(from: CreditCardDummy.card9, forDocument: card9Reference)
            } catch let error {
                print("ERROR writing card to Firestore \(error.localizedDescription)")
            }
            
            batch.commit()
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

