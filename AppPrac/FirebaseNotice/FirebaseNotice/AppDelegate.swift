//
//  AppDelegate.swift
//  FirebaseNotice
//
//  Created by JunHeeJo on 11/22/21.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        self.printFirebaseToken()
        return true
    }
    
    private func printFirebaseToken() {
        // Firebase가 각각의 기기에 부여한 인증토큰을 확인할 수 있다.
        Installations.installations().authTokenForcingRefresh(true) { result, error in
            if let error = error {
                print("ERROR: \(error)")
                return
            }
            
            guard let result = result else { return }
            print("Installation auth token: \(result.authToken)")
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

