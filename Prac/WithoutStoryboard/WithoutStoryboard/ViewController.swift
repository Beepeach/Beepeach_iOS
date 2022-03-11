//
//  ViewController.swift
//  WithoutStoryboard
//
//  Created by JunHeeJo on 3/12/22.
//

import UIKit

class ViewController: UIViewController {
    // 가장 먼저 Main을 삭제해줍니다.
    // LaunchScreen은 살려줍니다. 삭제하면 안돼요!
    
    // 삭제후 Info.plist에 가서 Main storyboard file base name key를 삭제해줍니다.
    // 그 다음 Application Scene Manifest -> Storyboard Name을 삭제시켜줍니다.

    // 끝이 아니라 이제 window 설정을 해줘야합니다.
    
    // SceneDelegate에서 window를 설정해줍니다.

    lazy var customLabel: UILabel = {
        let label = UILabel()
        label.text = "PreView!!"
        label.textColor = .systemRed
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemTeal
        
        self.view.addSubview(customLabel)
        NSLayoutConstraint.activate([
            customLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            customLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
}

#if DEBUG
import SwiftUI

struct TestVCRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        return ViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}

struct TestPreviewProvider: PreviewProvider {
    static var previews: some View {
        TestVCRepresentable()
    }
}
#endif
