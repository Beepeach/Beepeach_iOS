//
//  ViewController.swift
//  PickerView
//
//  Created by JunHeeJo on 10/23/21.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Properties
    let adjectives = ["Excellent", "Powerful", "Cool", "Hot"]
    let names = ["Beepeach", "Peach", "SomSom", "Zelda", "Link"]
    
    // MARK: @IBOutlet
    @IBOutlet weak var mixedNameLabel: UILabel!
    @IBOutlet weak var picker: UIPickerView!

    // MARK: @IBAction
    @IBAction func reportButton(_ sender: UIButton) {
        let firstSelectedRow = picker.selectedRow(inComponent: 0)
        let secondSelectedRow = picker.selectedRow(inComponent: 1)
        
        if firstSelectedRow >= 0, secondSelectedRow >= 0 {
            print(adjectives[firstSelectedRow], names[secondSelectedRow])
        }
    }
    
    @IBAction func Shuffle(_ sender: Any) {
        let firstRandomRow: Int = Int.random(in: 0..<adjectives.count)
        let secondRandomRow: Int = Int.random(in: 0..<names.count)
        
        picker.selectRow(firstRandomRow, inComponent: 0, animated: true)
        picker.selectRow(secondRandomRow, inComponent: 1, animated: true)
        
        mixedNameLabel.text = "\(adjectives[picker.selectedRow(inComponent: 0)]) \(names[picker.selectedRow(inComponent: 1)])"
    }
    

    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mixedNameLabel.text = ""
        picker.delegate = self
        picker.dataSource = self
    }
}


// MARK: - UIPickerViewDataSource
extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return adjectives.count
            
        case 1:
            return names.count
            
        default:
            return 0
        }
    }
}


// MARK: - UIPikcerViewDelegate
extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return adjectives[row]
            
        case 1:
            return names[row]
            
        default:
            return nil
        }
    }
    
    // 맨 처음 화면에 나타날때는 호출되지 않는다.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            print(adjectives[row])
            
        case 1:
            print(names[row])
            
        default:
            break
        }
    }
}
