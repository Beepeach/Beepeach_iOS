//
//  Content.swift
//  NetflixSample
//
//  Created by JunHeeJo on 11/25/21.
//

import Foundation
import UIKit

struct Content: Decodable {
    let sectionType: SectionType
    let sectionName: String
    let contentItem: [Item]
    
    enum SectionType: String, Decodable {
        case main
        case basic
        case large
        case rank
    }
}

struct Item: Decodable {
    let description: String
    let imageName: String
    
    var image: UIImage {
        return UIImage(named: self.imageName) ?? UIImage()
    }
}
