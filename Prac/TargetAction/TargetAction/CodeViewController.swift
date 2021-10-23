//
//  CodeViewController.swift
//  TargetAction
//
//  Created by JunHeeJo on 10/23/21.
//

import UIKit

class CodeViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var slider: UISlider!
    
    // @IBAction이 없이 구현
    @objc func actionOne() {
        print(#function)
    }
    
    // selector로 만들기위해서는 @objc 키워드가 필요하다.
    @objc func action(_ sender: Any) {
        view.backgroundColor = .black
    }
    
    func action(_ sender: Any, forEvent event: UIEvent) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // selector로 만드는 방법
        let selector = #selector(action(_:))
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        let sliderSelector = #selector(actionOne)
        slider.addTarget(self, action: sliderSelector, for: .valueChanged)
    }
}
