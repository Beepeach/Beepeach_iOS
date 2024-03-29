//
//  DetailDiaryViewController.swift
//  Diary
//
//  Created by JunHeeJo on 11/2/21.
//

import UIKit

class DetailDiaryViewController: UIViewController {
    // MARK: Properties
    var diary: Diary?
    var indexPath: IndexPath?
    let writeDiaryVCIndentifier: String = "WriteDiaryViewController"
    var starButton: UIBarButtonItem?
    
    // MARK: @IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: @IBAction
    @IBAction func tapEdit(_ sender: UIButton) {
        guard let writeDiaryVC: WriteDiaryViewController = self.storyboard?.instantiateViewController(withIdentifier: self.writeDiaryVCIndentifier) as? WriteDiaryViewController else {
            return
        }
        guard let indexPath = self.indexPath else {
            return
        }
        guard let diary = self.diary else {
            return
        }
        
        writeDiaryVC.diaryEditorMode = .edit(indexPath, diary)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(editDiaryNotification(_:)),
            name: NSNotification.Name("editDiary"),
            object: nil
        )
        
        self.navigationController?.pushViewController(writeDiaryVC, animated: true)
    }
    
    @objc private func editDiaryNotification(_ noti: Notification) {
        guard let diary = noti.object as? Diary else {
            return
        }
        
        self.diary = diary
        self.configureView()
    }
    
    @IBAction func tapDelete(_ sender: UIButton) {
        guard let uuidString = self.diary?.uuidString else {
            return
        }
        
        NotificationCenter.default.post(
            name: NSNotification.Name("deleteDiary"),
            object: uuidString,
            userInfo: nil
        )
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(starDiaryNotification(_:)),
            name: NSNotification.Name("starDiary"),
            object: nil
        )
    }
    
    private func configureView() {
        guard let diary = self.diary else { return }
        self.titleLabel.text = diary.title
        self.contentsTextView.text = diary.contents
        self.dateLabel.text = self.dateToString(date: diary.date)
        
        self.starButton = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(tapStarButton))
        self.starButton?.image = diary.isStar ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        self.starButton?.tintColor = .orange
        self.navigationItem.rightBarButtonItem = self.starButton
    }
    
    private func dateToString(date: Date) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEE)"
        formatter.locale = Locale(identifier: "ko_kr")
        
        return formatter.string(from: date)
    }
    
    @objc private func tapStarButton() {
        guard let isStar = self.diary?.isStar else {
            return
        }
        
        if isStar {
            self.starButton?.image = UIImage(systemName: "star")
        } else {
            self.starButton?.image = UIImage(systemName: "star.fill")
        }
        self.diary?.isStar = !isStar
        
        NotificationCenter.default.post(
            name: NSNotification.Name("starDiary"),
            object: [
                "diary": self.diary,
                "isStar": self.diary?.isStar ?? false,
                "uuidString": diary?.uuidString
            ],
            userInfo: nil)
    }
    
    @objc private func starDiaryNotification(_ noti: Notification) {
        guard let starDiary = noti.object as? [String: Any] else {
            return
        }
        guard let isStar = starDiary["isStar"] as? Bool else {
            return
        }
        guard let uuidString = starDiary["uuidString"] as? String else {
            return
        }
        guard let diary = self.diary else {
            return
        }
        
        if diary.uuidString == uuidString {
            self.diary?.isStar = isStar
            self.configureView()
        }
    }
    
    // MARK: Deinitializer
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
