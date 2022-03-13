//
//  ViewController.swift
//  SnapKitPrac
//
//  Created by JunHeeJo on 3/11/22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    let redView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemRed
        return view
    }()
    
    let greenView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        return view
    }()
    
    let blueView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        return view
    }()
    
    let purpleView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPurple
        return view
    }()
    
    let yellowView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemYellow
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemTeal
        
        self.view.addSubview(redView)
        redView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        // MultipleBy
        self.view.addSubview(greenView)
        greenView.snp.makeConstraints {
            $0.top.equalTo(redView.snp.bottom)
            $0.leading.trailing.equalTo(redView)
            $0.height.equalToSuperview().multipliedBy(0.5)
        }
        
        // Inset
        self.view.addSubview(blueView)
        blueView.snp.makeConstraints {
            $0.edges.equalTo(greenView).inset(UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50))
        }
        
        // Center
        self.view.addSubview(purpleView)
        purpleView.snp.makeConstraints {
            $0.width.height.equalTo(100)
            
            $0.center.equalTo(blueView)
            
            // $0.centerX.equalTo(blueView)
            // $0.centerY.equalTo(blueView)
        }
        
        // Other
        yellowView.snp.makeConstraints {
            $0.width.equalTo(100).priority(.high)
            
            $0.height.greaterThanOrEqualTo(100)
            
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
        }
    }
    
    private func withoutSnapKit() {
        redView.translatesAutoresizingMaskIntoConstraints = false
        redView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        redView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        redView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        redView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
}



#if DEBUG
import SwiftUI

struct VCRpresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        return ViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}

struct VCPreviewProvider: PreviewProvider {
    static var previews: some View {
        VCRpresentable()
    }
}
#endif
