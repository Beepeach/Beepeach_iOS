//
//  ViewController.swift
//  CustomCalendar
//
//  Created by JunHee Jo on 2021/06/22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Properties
    private let cellIdentifier: String = "CalendarCell"
    private var selectedDate = Date()
    private var totalDaySquares = [String]()
    
    // MARK: @IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    
    // MARK: @IBAction
    @IBAction func previousMonth(_ sender: Any) {
        selectedDate = CalendarHelper().minusMonth(date: selectedDate)
        configMonthCalendar()
    }
    @IBAction func nextMonth(_ sender: Any) {
        selectedDate = CalendarHelper().plusMonth(date: selectedDate)
        configMonthCalendar()
    }
    
    // ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setCellSize()
        configMonthCalendar()
    }
    
    private func setCellSize() {
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        let expectedHorizonCount: Int = 7
        let expectedVerticalCount: Int = 5
        
        let lineSpacing: CGFloat = flowLayout.minimumLineSpacing
        let itemSpacing: CGFloat = flowLayout.minimumInteritemSpacing
        
        let otherHorizonInset: CGFloat = itemSpacing * CGFloat(expectedHorizonCount - 1)
        let otherVerticalInset: CGFloat = lineSpacing * CGFloat(expectedVerticalCount - 1)
        
        
        let width = (view.frame.size.width - otherHorizonInset) / CGFloat(expectedHorizonCount)
        let height = (view.frame.size.height - otherVerticalInset ) / CGFloat(expectedVerticalCount)
        
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    private func configMonthCalendar() {
        totalDaySquares.removeAll()
        
        totalDaySquares = DaySquaresGenerator().create(selectedDate: selectedDate)
        
        monthLabel.text = CalendarHelper().yearString(date: selectedDate) + " " + CalendarHelper().monthString(date: selectedDate)
        
        collectionView.reloadData()
    }
}


// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalDaySquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as? CalendarCollectionViewCell else { return UICollectionViewCell() }
        
        cell.dayOfMonth.text = totalDaySquares[indexPath.item]
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}
