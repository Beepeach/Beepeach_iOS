//
//  ViewController.swift
//  AsyncPrac
//
//  Created by JunHeeJo on 10/27/21.
//

import UIKit

class ViewController: UIViewController {
    // MARK: @IBOutlet
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: @IBAction
    @IBAction func touchUpDownloadButton(_ sender: UIButton) {
        guard let imageURL: URL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3d/LARGE_elevation.jpg/1600px-LARGE_elevation.jpg") else {
            return
        }
                
        OperationQueue().addOperation {
            guard let imageData: Data = try? Data.init(contentsOf: imageURL) else {
                return
            }
            
            guard let image: UIImage = UIImage(data: imageData) else {
                return
            }
            OperationQueue.main.addOperation {
                self.imageView.image = image
            }
        }
    }
    
    // MARK ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
