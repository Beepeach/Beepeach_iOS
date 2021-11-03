//
//  StarViewController.swift
//  Diary
//
//  Created by JunHeeJo on 11/2/21.
//

import UIKit

class StarViewController: UIViewController {
    // MARK: Properties
    private let starCellIndentifier: String = "StarCell"
    private let detailDiaryVCIdentifier: String =  "DetailDiaryViewController"
    private var diaryList: [Diary] = []
    
    // MARK: @IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadStarDiaryList()
        self.configureCollectionView()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(editDiaryNotification(_:)),
            name: NSNotification.Name("editDiary"),
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(starDiaryNotification(_:)),
            name: NSNotification.Name("starDiary"),
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(deleteDiaryNotification(_:)),
            name: NSNotification.Name("deleteDiary"),
            object: nil
        )
    }
    
    private func loadStarDiaryList() {
        let userDefaults: UserDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "diaryList") as? [[String: Any]] else {
            return
        }
        self.diaryList = data.compactMap {
            guard let uuidString = $0["uuidString"] as? String else { return nil }
            guard let title = $0["title"] as? String else { return nil }
            guard let contents = $0["contents"] as? String else { return nil}
            guard let date = $0["date"] as? Date else { return nil}
            guard let isStar = $0["isStar"] as? Bool else { return nil }
            
            return Diary(uuidString: uuidString, title: title, contents: contents, date: date, isStar: isStar)
        }.filter({
            $0.isStar == true
        }).sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
    }
    
    private func configureCollectionView() {
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    @objc private func editDiaryNotification(_ noti: Notification) {
        guard let diary = noti.object as? Diary else {
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
        guard let diary = starDiary["diary"] as? Diary else {
            return
        }

        if isStar {
            self.diaryList.append(diary)
            self.diaryList = self.diaryList.sorted(by: {
                $0.date.compare($1.date) == .orderedDescending
            })
            self.collectionView.reloadData()
        } else {
            guard let index = self.diaryList.firstIndex(where: { $0.uuidString == uuidString }) else {
                return
            }
            self.diaryList.remove(at: index)
            self.collectionView.deleteItems(at: [IndexPath(item: index, section: 0)])
        }
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
}


// MARK: - UICollectionViewDataSource
extension StarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.diaryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: StarCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.starCellIndentifier, for: indexPath) as? StarCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let diary: Diary = self.diaryList[indexPath.item]
        
        cell.titleLabel.text = diary.title
        cell.dateLabel.text = self.dateToString(date: diary.date)
        
        return cell
    }
    
    private func dateToString(date: Date) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일 (EEEEE)"
        formatter.locale = Locale(identifier: "ko_kr")
        
        return formatter.string(from: date)
    }
}


// MARK: - UICollectionViewDelegate
extension StarViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailDiaryVC = self.storyboard?.instantiateViewController(withIdentifier: self.detailDiaryVCIdentifier) as? DetailDiaryViewController else {
            return
        }
        
        let diary: Diary = self.diaryList[indexPath.item]
        detailDiaryVC.diary = diary
        detailDiaryVC.indexPath = indexPath
        
        self.navigationController?.pushViewController(detailDiaryVC, animated: true)
    }
}


// MARK: - UICollectionViewDlegateFlowLayout
extension StarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 20, height: 80)
    }
}
