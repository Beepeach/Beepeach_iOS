//
//  URLViewController.swift
//  URLPrac
//
//  Created by JunHeeJo on 3/9/22.
//

import UIKit

class URLViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 안좋은 방법
        let urlString = "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"
        guard let url = URL(string: urlString) else {
            return
        }
        
        do {
            let imageData = try Data(contentsOf: url)
            imageView.image = UIImage(data: imageData)
        } catch {
            print(error)
        }
        
        guard let appleURL = URL(string: "https://apple.com") else {
            return
        }
        textView.text = try? String(contentsOf: appleURL, encoding: .utf8)
    }
}
