//
//  ViewController.swift
//  Operation
//
//  Created by JunHee Jo on 2021/06/28.
//

import UIKit

class ViewController: UIViewController {
    // MainOperationQueue 생성 방법
    let mainQueue: OperationQueue = OperationQueue.main
    
    // BackgroundOperationQueue 생성 방법
    let backgroundQueue: OperationQueue = OperationQueue()
    
    // isCancelled를 직접 추가
    var isCancelled: Bool = false
    
    
    @IBAction func startOperation(_ sender: Any) {
        isCancelled = false
        
        // Block으로 바로 operation을 추가하는 방법
        
        backgroundQueue.addOperation {
            autoreleasepool {
                for _ in 1 ... 20 {
                    guard self.isCancelled == false else { return }
                    
                    print("🍎", terminator: "")
                    Thread.sleep(forTimeInterval: 0.3)
                }
            }
        }
        
        
        // BlockOperation을 생성하는 방법
        
        let block = BlockOperation {
            autoreleasepool {
                for _ in 1 ... 20 {
                    guard self.isCancelled == false else { return }
                    
                    print("🍏", terminator: "")
                    Thread.sleep(forTimeInterval: 0.6)
                }
            }
        }
        
        // 생성한 blockOperation을 추가하는 방법
        backgroundQueue.addOperation(block)
        
        // 기존 blockOperation에 operation 추가하는 방법
        block.addExecutionBlock {
            autoreleasepool {
                for _ in 1 ... 20 {
                    guard self.isCancelled == false else { return }
                    
                    print("🍑", terminator: "")
                    Thread.sleep(forTimeInterval: 0.9)
                }
            }
        }
        
        // block이 끝나면 실행시킬 코드
        block.completionBlock = {
            print("Done")
        }
        
    }
    
    @IBAction func stopOperation(_ sender: Any) {
        isCancelled = true
        backgroundQueue.cancelAllOperations()
    }
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        stopOperation(self)
    }
}

