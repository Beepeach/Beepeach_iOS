//
//  ViewController.swift
//  KingfisherPrac
//
//  Created by JunHeeJo on 3/14/22.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        useURLSession()
       useKingfisherWithOptions()
    }
    
    
    
    
    private func syncDownload() {
        let urlString = "https://picsum.photos/300"
        guard let url = URL(string: urlString) else {
            return
        }
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        print("is Main Thread?: ", Thread.isMainThread)
        
        imageView.image = UIImage(data: data)
    }
    
    private func asyncDownload() {
        DispatchQueue.global().async {
            let urlString = "https://picsum.photos/300"
            guard let url = URL(string: urlString) else {
                return
            }
            guard let data = try? Data(contentsOf: url) else {
                return
            }
            print("is Main Thread?: ", Thread.isMainThread)
            
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
            }
        }
    }
    
    private func useURLSession() {
        let urlString = "https://images.unsplash.com/photo-1543373014-cfe4f4bc1cdf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3448&q=80"
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                      return
            }
            guard let data = data else {
                return
            }
            
            print("is Main Thread?: ", Thread.isMainThread)
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
            }
        }.resume()
    }
    
    private func useKingfisher() {
        let urlString = "https://picsum.photos/300"
        let url = URL(string: urlString)
        
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url)
    }
    
    private func useKingfisherWithPlaceholder() {
        let urlString = "https://picsum.photosㅋㅋㅋ"
        let url = URL(string: urlString)
        
        imageView.contentMode = .scaleAspectFit
        imageView.kf.setImage(with: url, placeholder: UIImage(systemName: "gear"))
    }
    
    private func useKingfisherWithOptions() {
        let urlString = "https://picsum.photos/300"
        let url = URL(string: urlString)
        
        imageView.contentMode = .scaleAspectFit
        
        imageView.kf.setImage(with: url,
                              options: [.transition(.fade(1.0)), .forceTransition]
        )
    }
    
    private func imageCache() {
        
    }
}

