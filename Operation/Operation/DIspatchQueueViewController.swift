//
//  DIspatchQueueViewController.swift
//  Operation
//
//  Created by JunHee Jo on 2021/07/02.
//

import UIKit

class DIspatchQueueViewController: UIViewController {
    
    // Serial Queue 생성 방법
    private let serialQueue: DispatchQueue = DispatchQueue(label: "serialQueue")
    
    // Concurrent Queue 생성 방법
    private let concurrentQueue: DispatchQueue = DispatchQueue(label: "concurrnetQueue", attributes: .concurrent)
    
    @IBAction func async(_ sender: Any) {
        
    }

    @IBAction func sync(_ sender: Any) {
        
    }
    
    @IBAction func concurrentPerform(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
}
