//
//  TimerViewController.swift
//  Tiemr
//
//  Created by JunHee Jo on 2021/06/28.
//

import UIKit

class TimerViewController: UIViewController {
    // MARK: Properties
    private lazy var formatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        
        return formatter
    }()
    
    private var timer: Timer?
    
    // MARK: @IBOutlet
    @IBOutlet weak var timeLable: UILabel!

    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        stopTimer()
    }
    
    private func startTimer() {
        guard timer == nil else { return }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
            guard timer.isValid else { return }
            
            print(timer)
            self.updateTimeLabel()
        })
    }
    
    private func updateTimeLabel() {
        timeLable.text = formatter.string(from: Date())
    }
    
    private func stopTimer() {
        timer?.invalidate()
    }
}
