//
//  ViewController.swift
//  MVCBasic
//
//  Created by JunHeeJo on 1/25/22.
//

import UIKit

class ViewController: UIViewController {
    // MARK: @IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    
    // MARK: Properties
    let notes: [Note] = [
        Note(title: "안녕", contents: "안뇽?"),
        Note(title: "반가워", contents: "반가워요"),
        Note(title: "잘가", contents: "다음에 봐요")
    ]
 
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK: @IBActions
    @IBAction func tapChange(_ sender: UIButton) {
        let random: Int = createRandomInt()
        let note = notes[random]
        
        titleLabel.text = note.title
        contentsLabel.text = note.contents
    }
    
    private func createRandomInt() -> Int {
        let random: Int = Int.random(in: 0 ..< notes.count)
        
        return random
    }
}

