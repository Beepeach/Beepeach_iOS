//
//  ViewController.swift
//  Timer
//
//  Created by JunHeeJo on 11/7/21.
//

import UIKit
import AudioToolbox

enum TimerStatus {
    case start
    case pause
    case end
}

class ViewController: UIViewController {
    // MARK: Properties
    private var duration: Int = 60
    private var timerStatus: TimerStatus = .end
    private var timer: DispatchSourceTimer?
    private var currentSeconds: Int = 0

    // MARK: @IBOutlet
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var toggleButton: UIButton!
    
    // MARK: @IBAction
    @IBAction func tapCancel(_ sender: UIButton) {
        switch self.timerStatus {
        case .start, .pause:
            self.stopTimer()
            
        default:
            break
        }
    }
    
    private func stopTimer() {
        if self.timerStatus == .pause {
            self.timer?.resume()
        }
        
        self.timerStatus = .end
        self.cancelButton.isEnabled = false
        self.toggleButton.isSelected = false
        
        UIView.animate(withDuration: 0.3, animations: {
            self.timerLabel.alpha = 0.0
            self.progressView.alpha = 0.0
            self.datePicker.alpha = 1.0
            self.imageView.transform = .identity
        })
        
        self.timer?.cancel()
        self.timer = nil
    }
    
    @IBAction func tapToggle(_ sender: UIButton) {
        self.duration = Int(self.datePicker.countDownDuration)
        debugPrint(self.duration)
        
        switch self.timerStatus {
        case .end:
            self.currentSeconds = self.duration
            self.timerStatus = .start
            
            UIView.animate(withDuration: 0.3, animations: {
                self.timerLabel.alpha = 1.0
                self.progressView.alpha = 1.0
                self.datePicker.alpha = 0.0
            })
            
            self.toggleButton.isSelected = true
            self.cancelButton.isEnabled = true
            self.startTimer()
            
        case .start:
            self.timerStatus = .pause
            self.toggleButton.isSelected = false
            self.timer?.suspend()
            
        case .pause:
            self.timerStatus = .start
            self.toggleButton.isSelected = true
            self.timer?.resume()
        }
    }
    
    private func startTimer() {
        if self.timer == nil {
            self.timer = DispatchSource.makeTimerSource(flags: [], queue: .main)
            self.timer?.schedule(deadline: .now(), repeating: 1)
            self.timer?.setEventHandler(handler: { [weak self] in
                guard let self = self else { return }
                
                let hour = self.currentSeconds / 3600
                let minutes = (self.currentSeconds % 3600) / 60
                let seconds = (self.currentSeconds % 3600) % 60
                self.timerLabel.text = String(format: "%02d:%02d:%02d", hour, minutes, seconds)
                
                self.progressView.progress = Float(self.currentSeconds) / Float(self.duration)
                UIView.animate(withDuration: 0.3, delay: 0, animations: {
                    self.imageView.transform = CGAffineTransform(rotationAngle: .pi)
                })
                UIView.animate(withDuration: 0.3, delay: 0.3, animations: {
                    self.imageView.transform = CGAffineTransform(rotationAngle: .pi * 2)
                })
                
                debugPrint(self.progressView.progress)
                
                self.currentSeconds -= 1
                
                if self.currentSeconds <= 0 {
                    self.stopTimer()
                    AudioServicesPlaySystemSound(1005)
                }
            })
            self.timer?.resume()
        }
    }
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureToggleButton()
    }
    
    private func configureToggleButton() {
        self.toggleButton.setTitle("시작", for: .normal)
        self.toggleButton.setTitle("일시정지", for: .selected)
    }
}

