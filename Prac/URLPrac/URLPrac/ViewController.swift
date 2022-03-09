//
//  ViewController.swift
//  URLPrac
//
//  Created by JunHeeJo on 3/9/22.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        
        let urlString = "http://www.naver.com"
        guard let url = URL(string: urlString) else {
            return
        }
        let request = URLRequest(url: url)
        
        webView.load(request)
    }
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error)
    }
}

