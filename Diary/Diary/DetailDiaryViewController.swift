//
//  DetailDiaryViewController.swift
//  Diary
//
//  Created by JunHeeJo on 11/2/21.
//

import UIKit

// MARK: - DetailDiaryViewDelegate
protocol DetailDiaryViewDelegate: AnyObject {
    func didSelectDelete(indexPath: IndexPath)
}

// MARK: - DetailDiaryViewController
class DetailDiaryViewController: UIViewController {
    // MARK: Properties
    var diary: Diary?
    var indexPath: IndexPath?
    weak var delegate: DetailDiaryViewDelegate?
    let writeDiaryVCIndentifier: String = "WriteDiaryViewController"

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
        /*
        guard let item = noti.userInfo?["indexPath.item"] as? Int else {
            return
        }
        */
        
        self.diary = diary
        self.configureView()
    }
    
    @IBAction func tapDelete(_ sender: UIButton) {
        guard let indexPath = self.indexPath else {
            return
        }
        
        self.delegate?.didSelectDelete(indexPath: indexPath)
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    private func configureView() {
        guard let diary = self.diary else { return }
        self.titleLabel.text = diary.title
        self.contentsTextView.text = diary.contents
        self.dateLabel.text = self.dateToString(date: diary.date)
    }
    
    private func dateToString(date: Date) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEE)"
        formatter.locale = Locale(identifier: "ko_kr")
        
        return formatter.string(from: date)
    }
    
    
    // MARK: Deinitializer
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
