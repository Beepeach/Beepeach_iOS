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
            
            return Diary(title: title, contents: contents, date: date, isStar: isStar)
        }
        
        self.diaryList = self.diaryList.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
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
        formatter.dateFormat = "yy년 MM월 dd일(EEEE)"
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
        detailDiaryVC.delegate = self
        self.navigationController?.pushViewController(detailDiaryVC, animated: true)
    }
}


// MARK: - DetailDiaryViewDelegate
extension ViewController: DetailDiaryViewDelegate {
    func didSelectDelete(indexPath: IndexPath) {
        self.diaryList.remove(at: indexPath.item)
        self.collectionView.deleteItems(at: [indexPath])
    }
}
