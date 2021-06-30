//
//  CustomOperation.swift
//  Operation
//
//  Created by JunHee Jo on 2021/06/30.
//

import UIKit

class CustomOperation: Operation {
    let work: String
    
    init(work: String) {
        self.work = work
    }
    
    override func main() {
        autoreleasepool {
            for _ in 1 ... 10 {
                guard isCancelled == false else { return }
                
                print(work, terminator: " ")
                Thread.sleep(forTimeInterval: 1.2)
            }
        }
    }
}
