//
//  ViewController.swift
//  CoreDataContext
//
//  Created by JunHeeJo on 2/25/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var list: [TestEntity] = []

    @IBAction func tapCreate(_ sender: Any) {
        let newEntity = TestEntity(context: CoreDataManager.shared.mainContext)
        newEntity.name = "Test"
        print("Create Entity")
    }
    
    @IBAction func tapRead(_ sender: Any) {
        let fetchRequest: NSFetchRequest<TestEntity> = TestEntity.fetchRequest()
        do {
            list = try CoreDataManager.shared.mainContext.fetch(fetchRequest)
            print(list)
            print(list.first as Any)
        } catch {
            print(error)
        }
    }
    
    @IBAction func tapDelete(_ sender: Any) {
        guard let targetEntity: TestEntity = list.first else {
            return
        }
        CoreDataManager.shared.mainContext.delete(targetEntity)
        print("Delete")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

