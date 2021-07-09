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
    private var selectedDate: Date = Date()
    private var totalDaySquares: [String] = []
    
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
    
    public func getSelectedDate() -> Date {
        return self.selectedDate
    }
    
    public func setSelectedDate(date: Date) {
        self.selectedDate = date
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sender = sender as? UICollectionViewCell else { return }
        
        guard let destinationNav = segue.destination as? UINavigationController else { return }
        guard let destinationVC = destinationNav.children.first as? DetailDateViewController else { return }
        
        guard let indexpath = collectionView.indexPath(for: sender) else { return }
        guard let targetCell = collectionView.cellForItem(at: indexpath) as? CalendarCollectionViewCell else { return }
        
        destinationVC.date = targetCell.getDate()
    }
}


// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalDaySquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as? CalendarCollectionViewCell else { return UICollectionViewCell() }
        
        guard let year: Int = DateCalculator().extractYearComponent(date: selectedDate).year,
              let month: Int = DateCalculator().extractMonthComponent(date: selectedDate).month else {
            return CalendarCollectionViewCell()
        }
        
        if let day: Int = Int(totalDaySquares[indexPath.item]) {
            let date: Date = DateGenerator().createStartOfDay(year: year, month: month, day: day)
            cell.setDate(date: date)
        }
    
        cell.dayOfMonth.text = totalDaySquares[indexPath.item]
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if totalDaySquares[indexPath.row] == "" {
            return false
        }
        
        return true
    }
}
