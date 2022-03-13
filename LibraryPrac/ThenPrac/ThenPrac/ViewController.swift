//
//  ViewController.swift
//  ThenPrac
//
//  Created by JunHeeJo on 3/11/22.
//

import UIKit
import Then

class ViewController: UIViewController {
    let anotherBeforeLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.textColor = .systemTeal
        label.text = "Before Text"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    let afterLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 30, weight: .semibold)
        $0.textColor = .systemRed
        $0.text = "After Text"
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBeforeLabel()
        setupAfterLabel()
    }
    
    private func setupBeforeLabel() {
        let beforeLabel: UILabel = UILabel()
        beforeLabel.font = .systemFont(ofSize: 30, weight: .semibold)
        beforeLabel.textColor = .systemTeal
        beforeLabel.text = "Before Text"
        beforeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(beforeLabel)
        
        NSLayoutConstraint.activate([
            beforeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            beforeLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100)
        ])
    }
    
    private func setupAfterLabel() {
        self.view.addSubview(afterLabel)
        
        NSLayoutConstraint.activate([
            afterLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            afterLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 100)
        ])
    }
}


#if DEBUG
import SwiftUI

struct VCRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        return ViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}

struct VCPreview: PreviewProvider {
    static var previews: some View {
        VCRepresentable()
    }
}
#endif
