//
//  Friend.swift
//  Codable
//
//  Created by JunHeeJo on 10/26/21.
//

import Foundation

struct Friend: Codable {
    struct Address: Codable {
        let country: String
        let city: String
    }
    
    enum CodingKeys: String, CodingKey {
        case name, age
        case addressInfo = "address_info"
    }
    
    let name: String
    let age: Int
    let addressInfo: Address
    
    var nameAndAge: String {
        return self.name + "(\(self.age))"
    }
    var fullAddress: String {
        return self.addressInfo.city + ", " + self.addressInfo.country
    }
}
