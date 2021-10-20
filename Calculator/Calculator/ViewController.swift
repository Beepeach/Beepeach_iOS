//
//  ViewController.swift
//  Calculator
//
//  Created by JunHeeJo on 10/20/21.
//

import UIKit

enum Operation {
    case add
    case subtract
    case divide
    case multiply
    case unknown
}

class ViewController: UIViewController {
    //MARK: Properties
    var displayNumber: String = ""
    var firstOperand: String = ""
    var secondOperand: String = ""
    var result: String = ""
    var currentOperation: Operation = .unknown
    
    // MARK: @IBOutlet
    @IBOutlet weak var resultLabel: UILabel!
    
    
    // MARK: @IBAction
    @IBAction func tapNumberButton(_ sender: UIButton) {
        guard let value = sender.title(for: .normal) else { return }
        if displayNumber.count < 9 {
            displayNumber += value
            resultLabel.text = displayNumber
        }
    }
    
    @IBAction func tapClearButton(_ sender: UIButton) {
        displayNumber = ""
        firstOperand = ""
        secondOperand = ""
        result = ""
        currentOperation = .unknown
        self.resultLabel.text = "0"
    }
    
    @IBAction func tapDivideButton(_ sender: UIButton) {
        operate(.divide)
    }
    
    @IBAction func tapMultiplyButton(_ sender: UIButton) {
        operate(.multiply)
    }
    
    @IBAction func tapSubtractButton(_ sender: UIButton) {
        operate(.subtract)
    }
    
    @IBAction func tapAddButton(_ sender: UIButton) {
        operate(.add)
    }
    
    @IBAction func tapDotButton(_ sender: UIButton) {
        if displayNumber.count < 8,
            !displayNumber.contains(".") {
            displayNumber += displayNumber.isEmpty ? "0." : "."
            resultLabel.text = displayNumber
        }
    }
    
    @IBAction func tapEqualButton(_ sender: UIButton) {
        operate(currentOperation)
    }
    
    func operate(_ operation: Operation) {
        if currentOperation != .unknown {
            if !displayNumber.isEmpty {
                secondOperand = displayNumber
                displayNumber = ""
                
                guard let firstOperand = Double(firstOperand) else { return }
                guard let secondOperand = Double(secondOperand) else { return }
                
                switch currentOperation {
                case .add:
                    result = "\(firstOperand + secondOperand)"
                    
                case .subtract:
                    result = "\(firstOperand - secondOperand)"
                    
                case .divide:
                    result = "\(firstOperand / secondOperand)"
                    
                case .multiply:
                    result = "\(firstOperand * secondOperand)"
                    
                default:
                    break
                }
                
                if let result = Double(self.result), result.truncatingRemainder(dividingBy: 1) == 0 {
                    self.result = "\(Int(result))"
                }
                
                self.firstOperand = result
                resultLabel.text = result
            }
            
            self.currentOperation = operation
        } else {
            firstOperand = displayNumber
            currentOperation = operation
            displayNumber = ""
        }
    }
    
    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

