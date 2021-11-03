//
//  ViewController.swift
//  Diary
//
//  Created by JunHeeJo on 11/2/21.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Properties
    private let cellIdentifier: String = "DiaryCell"
    private let detailDiaryVCIdentifier: String =  "DetailDiaryViewController"
    private var diaryList: [Diary] = [] {
        didSet {
            self.saveDiaryList()
        }
    }
    
    private func saveDiaryList() {
        let date = self.diaryList.map {
            [
                "uuidString": $0.uuidString,
                "title": $0.title,
                "contents": $0.contents,
                "date": $0.date,
                "isStar": $0.isStar
            ]
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(date, forKey: "diaryList")
    }

    // MARK: @IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
        self.loadDiaryList()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(editDiaryNotification(_:)),
            name: NSNotification.Name.init(rawValue: "editDiary"),
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(starDiaryNotification(_:)),
            name: NSNotification.Name("starDiary"),
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(deleteDiaryNotification(_:)),
            name: NSNotification.Name("deleteDiary"),
            object: nil)
    }
    
    private func configureCollectionView() {
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    private func loadDiaryList() {
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "diaryList") as? [[String: Any]] else { return }
        self.diaryList = data.compactMap {
            guard let uuidString = $0["uuidString"] as? String else {
                return nil
            }
            guard let title = $0["title"] as? String else {
                return nil
            }
            guard let contents = $0["contents"] as? String else {
                return nil
            }
            guard let date = $0["date"] as? Date else {
                return nil
            }
            guard let isStar = $0["isStar"] as? Bool else {
                return nil
            }
            
            return Diary(uuidString: uuidString, title: title, contents: contents, date: date, isStar: isStar)
        }
        
        self.diaryList = self.diaryList.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
    }
    
    @objc private func editDiaryNotification(_ noti: Notification) {
        guard let diary: Diary = noti.object as? Diary else {
            return
        }
        guard let index = self.diaryList.firstIndex(where: { $0.uuidString == diary.uuidString }) else {
            return
        }
        self.diaryList[index] = diary
        self.diaryList = self.diaryList.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
        
        self.collectionView.reloadData()
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
        guard let index = self.diaryList.firstIndex(where: { $0.uuidString == uuidString }) else {
            return
        }
        
        self.diaryList[index].isStar = isStar
    }
    
    @objc private func deleteDiaryNotification(_ noti: Notification) {
        guard let uuidString = noti.object as? String else {
            return
        }
        guard let index = self.diaryList.firstIndex(where: { $0.uuidString == uuidString }) else {
            return
        }
        
        self.diaryList.remove(at: index)
        self.collectionView.deleteItems(at: [IndexPath(item: index, section: 0)])
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let writeDiaryVC: WriteDiaryViewController = segue.destination as? WriteDiaryViewController {
            writeDiaryVC.delegate = self
        }
    }
}


// MARK: - WriteDiaryViewDelegate
extension ViewController: WriteDiaryViewDelegate {
    func didSelectRegister(diary: Diary) {
        self.diaryList.append(diary)
        self.diaryList = self.diaryList.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
        self.collectionView.reloadData()
    }
}


// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.diaryList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as?  DiaryCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let diary: Diary = self.diaryList[indexPath.item]
        
        cell.titleLabel.text = diary.title
        cell.dateLabel.text = self.dateToString(date: diary.date)
        
        return cell
    }
    
    private func dateToString(date: Date) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_kr")
        
        return formatter.string(from: date)
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 2) - 20, height: 200)
    }
}


// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailDiaryVC: DetailDiaryViewController = self.storyboard?.instantiateViewController(withIdentifier: self.detailDiaryVCIdentifier) as? DetailDiaryViewController else {
            return
        }
        
        let diary: Diary = self.diaryList[indexPath.item]
        detailDiaryVC.diary = diary
        detailDiaryVC.indexPath = indexPath
        self.navigationController?.pushViewController(detailDiaryVC, animated: true)
    }
}
