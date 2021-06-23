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
    private var totalSquares = [String]()
    
    // MARK: @IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    
    // MARK: @IBAction
    @IBAction func previousMonth(_ sender: Any) {
        selectedDate = CalendarHelper().minusMonth(date: selectedDate)
        setMonthView()
    }
    @IBAction func nextMonth(_ sender: Any) {
        selectedDate = CalendarHelper().plusMonth(date: selectedDate)
        setMonthView()
    }
    
    // ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setCellSize()
        setMonthView()
    }
    
    private func setCellSize() {
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        let lineSpacing: CGFloat = flowLayout.minimumLineSpacing
        let itemSpacing: CGFloat = flowLayout.minimumInteritemSpacing
            
        let expectedHorizonCount: Int = 7
        let expectedVerticalCount: Int = 5
        
        let width = (collectionView.frame.size.width - lineSpacing) / CGFloat(expectedHorizonCount)
        let height = (collectionView.frame.size.height - itemSpacing) / CGFloat(expectedVerticalCount)
        
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    private func setMonthView() {
        totalSquares.removeAll()
        
        let daysInMonth = CalendarHelper().daysInMonth(date: selectedDate)
        let firstDayOfMonth = CalendarHelper().firstOfMonth(date: selectedDate)
        let startingSpaces = CalendarHelper().weekDay(date: firstDayOfMonth)
        
        let maxSquareCount: Int = 42
        var count: Int = 1
        
        while count <= maxSquareCount {
            if (count <= startingSpaces) || (count - startingSpaces > daysInMonth) {
                totalSquares.append("")
            } else {
                totalSquares.append(String(count - startingSpaces))
            }
            
            count += 1
        }
        
        monthLabel.text = CalendarHelper().yearString(date: selectedDate) + " " + CalendarHelper().monthString(date: selectedDate)
        
        collectionView.reloadData()
    }
}


// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as? CalendarCollectionViewCell else { return UICollectionViewCell() }
        
        cell.dayOfMonth.text = totalSquares[indexPath.item]
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}
