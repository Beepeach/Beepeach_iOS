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

    // MARK: @IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: @IBAction
    @IBAction func tapEdit(_ sender: UIButton) {
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
}
