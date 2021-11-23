//
//  Alert.swift
//  DrinkWater
//
//  Created by JunHeeJo on 11/23/21.
//

import Foundation

struct Alert: Codable {
    var id: String = UUID().uuidString
    let date: Date
    var isOn: Bool
    
    var hourAndMin: String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        
        return formatter.string(from: self.date)
    }
    
    var ampm: String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "a"
        formatter.locale = Locale(identifier: "ko_KR")
        
        return formatter.string(from: self.date)
    }
}
