//
//  CalendarCollectionViewCell.swift
//  CustomCalendar
//
//  Created by JunHee Jo on 2021/06/23.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    private var date: Date?
    
    @IBOutlet weak var dayOfMonth: UILabel!
    
    public func getDate() -> Date {
        return self.date ?? Date()
    }
    
    public func setDate(date: Date) {
        self.date = date
    }
}
