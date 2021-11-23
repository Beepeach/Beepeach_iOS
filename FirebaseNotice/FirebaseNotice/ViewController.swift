//
//  ViewController.swift
//  FirebaseNotice
//
//  Created by JunHeeJo on 11/22/21.
//

import UIKit
import FirebaseRemoteConfig
import FirebaseAnalytics

class ViewController: UIViewController {
    // MARK: Properties
    var remoteConfig: RemoteConfig?
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureRemoteConfig()
    }
    
    private func configureRemoteConfig() {
        remoteConfig = RemoteConfig.remoteConfig()
        
        let setting = RemoteConfigSettings()
        // 최대한 자주 원격구성을 가져올 수 있도록 설정
        setting.minimumFetchInterval = 0
        
        remoteConfig?.configSettings = setting
        
        remoteConfig?.setDefaults(fromPlist: "RemoteConfigDefault")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.getNotice()
    }
}

// MARK: - ViewController getNotice remoteConfig
extension ViewController {
    func getNotice() {
        guard let remoteConfig = self.remoteConfig else { return }
        remoteConfig.fetch { [weak self] status, _ in
            if status == .success {
                remoteConfig.activate(completion: nil)
            } else {
                print("ERROR: Config not fetched")
            }
            
            guard let self = self else { return }
            
            if !self.isNoticeHidden(remoteConfig) {
                let notiveVC = NoticeViewController(nibName: "NoticeViewController", bundle: nil)
                notiveVC.modalPresentationStyle = .custom
                notiveVC.modalTransitionStyle = .crossDissolve
                
                let title = (remoteConfig["title"].stringValue ?? "").replacingOccurrences(of: "\\n", with: "\n")
                let detail = (remoteConfig["detail"].stringValue ?? "").replacingOccurrences(of: "\\n", with: "\n")
                let date = (remoteConfig["date"].stringValue ?? "").replacingOccurrences(of: "\\n", with: "\n")
                
                notiveVC.noticeContents = (title: title, detail: detail, date: date)
                self.present(notiveVC, animated: true, completion: nil)
            } else {
                self.showEventAlert()
            }
        }
    }
    
    func isNoticeHidden(_ remoteConfig: RemoteConfig) -> Bool {
        return remoteConfig["isHidden"].boolValue
    }
}


// MARK: - ViewController showEventAlert() A/BTesting
extension ViewController {
    func showEventAlert() {
        guard let remoteConfig = remoteConfig else { return }
        
        remoteConfig.fetch { [weak self] status, _ in
            if status == .success {
                remoteConfig.activate(completion: nil)
            } else {
                print("Config not fetched")
            }
            
            let message = remoteConfig["message"].stringValue ?? "메세지를 못받았어용"
            
            let alertController = UIAlertController(title: "깜짝이벤트", message: message, preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
                // Google Analytics가 기록하게 하기
                Analytics.logEvent("promotionAlert", parameters: nil)
            }
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            
            self?.present(alertController, animated: true, completion: nil)
        }
    }
}
