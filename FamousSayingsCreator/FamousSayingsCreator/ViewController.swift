//
//  ViewController.swift
//  FamousSayingsCreator
//
//  Created by JunHeeJo on 10/17/21.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Properties
    let quotes = [
        Quote(contents: "안녕하세요??", name: "Beepeach"),
        Quote(contents: "반가워요", name: "Peach"),
        Quote(contents: "배고프다", name: "Me")
    ]
    
    // MARK: @IBOutlet
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: @IBAction
    @IBAction func tapQuoteGeneratorButton(_ sender: UIButton) {
        
        // 0 ~ 2 생성
        let random = Int(arc4random_uniform(2))
        let quote = quotes[random]
        self.quoteLabel.text = quote.contents
        self.nameLabel.text = quote.name
    }

    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
