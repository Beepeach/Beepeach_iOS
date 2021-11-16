//
//  CardDetailViewController.swift
//  CreditCardList
//
//  Created by JunHeeJo on 11/16/21.
//

import UIKit
import Lottie

class CardDetailViewController: UIViewController {
    // MARK: Properties
    var promotionDetail: PromotionDetail?
    
    // MARK: @IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lottieAnimationView: AnimationView!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var benefitConditionLabel: UILabel!
    @IBOutlet weak var benefitDateLabel: UILabel!
    @IBOutlet weak var benefitDetailLabel: UILabel!
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animationView = AnimationView(name: "money")
        lottieAnimationView.contentMode = .scaleAspectFit
        lottieAnimationView.addSubview(animationView)
        animationView.frame = lottieAnimationView.bounds
        animationView.loopMode = .loop
        animationView.play()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let detail = promotionDetail else { return }
        
        titleLabel.text = """
        \(detail.companyName)카드 쓰면
        \(detail.amount)만원 드려요.
        """
        periodLabel.text = detail.period
        conditionLabel.text = detail.condition
        benefitConditionLabel.text = detail.benefitCondition
        benefitDetailLabel.text = detail.benefitDetail
        benefitDateLabel.text = detail.benefitDate
    }
}
