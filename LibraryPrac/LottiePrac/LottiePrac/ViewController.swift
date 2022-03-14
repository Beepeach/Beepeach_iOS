//
//  ViewController.swift
//  LottiePrac
//
//  Created by JunHeeJo on 3/14/22.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    @IBOutlet weak var animationView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 기본값입니다. 1번만 실행됩니다.
        // animationView.loopMode = .playOnce
        
        // 계속해서 반복합니다.
        // animationView.loopMode = .loop
        
        // 계속해서 반복하는데 재생후 역재생을 실행합니다.
        // animationView.loopMode = .autoReverse

        // n번만큼 반복합니다.
        // animationView.loopMode = .repeat(2)

        // n번만큼 재생과 역재생을 반복합니다.
        // animationView.loopMode = .repeatBackwards(2)
    }
    
    
    @IBAction func pause(_ sender: Any) {
        animationView.pause()
        
        // animationView.stop()
    }
    
    
    @IBAction func progress(_ sender: Any) {
        animationView.play(fromProgress: 0.5, toProgress: 1.0)
    }
    
    
    @IBAction func frame(_ sender: Any) {
        print(animationView.animation?.startFrame as Any)
        print(animationView.animation?.endFrame as Any)
        animationView.play(fromFrame: 100, toFrame: 125)
    }
    
    
    @IBAction func play(_ sender: Any) {
        animationView.play()
    }
    
    func properties() {
        // 애니메이션의 실행 속도를 설정합니다.
        // animationView.animationSpeed
        
        // 애니메이션이 play중인지 확인합니다.
        // animationView.isAnimationPlaying
        
        // 애니메이션의 현재 progress를 리턴합니다.
        // animationView.currentProgress
        
        // 애니메이션의 현재 frame을 리턴합니다.
        // animationView.currentFrame
    }
}

