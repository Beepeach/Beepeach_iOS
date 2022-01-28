//
//  NoticeViewController.swift
//  FirebaseNotice
//
//  Created by JunHeeJo on 11/22/21.
//

import UIKit

class NoticeViewController: UIViewController {
    // MARK: Properties
    var noticeContents: (title: String, detail: String, date: String)?
    
    // MARK: @IBOutlet
    @IBOutlet weak var noticeView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        noticeView.layer.cornerRadius = 6
        view.backgroundColor = .black.withAlphaComponent(0.5)
        
        guard let noticeContents = noticeContents else { return }
        titleLabel.text = noticeContents.title
        detailLabel.text = noticeContents.detail
        dateLabel.text = noticeContents.date
    }
    
    // MARK: @IBAction
    @IBAction func TapDoneButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
