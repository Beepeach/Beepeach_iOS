//
//  DependancyViewController.swift
//  Operation
//
//  Created by JunHee Jo on 2021/06/30.
//

import UIKit

class DependancyViewController: UIViewController {
    private let background: OperationQueue = OperationQueue()
    private let main: OperationQueue = OperationQueue.main
    
    private var mainOperations: [Operation] = []
    private var backgroundOperations : [Operation] = []
    private var isCancelled: Bool = false
    
    // MARK: @IBAction
    @IBAction func start(_ sender: Any) {
        setToDefault()
        
        DispatchQueue.global().async { [self] in
            // ?? 글로벌에서 했는데 UI가 멈추네..?
            let beeOperation: BlockOperation = createBlockOperation(work: "🐝")
            beeOperation.completionBlock = {
                print("BeeOperation is Done")
            }
            mainOperations.append(beeOperation)
            
            let peachOperation: CustomOperation = CustomOperation(work: "🍑")
            peachOperation.completionBlock = {
                print("PeachOperation is Done")
            }
            peachOperation.addDependency(beeOperation)
            backgroundOperations.append(peachOperation)
            
            let redAppleOperation: CustomOperation = CustomOperation(work: "🍎")
            redAppleOperation.completionBlock = {
                print("RedAppleOperation is Done")
            }
            redAppleOperation.addDependency(peachOperation)
            backgroundOperations.append(redAppleOperation)
            
            background.addOperations(backgroundOperations, waitUntilFinished: false)
            main.addOperations(mainOperations, waitUntilFinished: false)
        }
    }
    
    private func setToDefault() {
        isCancelled = false
        mainOperations.removeAll()
        backgroundOperations.removeAll()
    }
    
    private func createBlockOperation(work: String) -> BlockOperation {
        let block = BlockOperation {
            autoreleasepool {
                for _ in 1 ... 10 {
                    guard self.isCancelled == false else { return }
                    print(work, terminator: " ")
                    Thread.sleep(forTimeInterval: 0.5)
                }
            }
        }
        
        return block
    }
    
    @IBAction func stop(_ sender: Any) {
        isCancelled = true
        background.cancelAllOperations()
        mainOperations.forEach { $0.cancel() }
    }
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stop(self)
    }
    
}
