//
//  CoreDataManager.swift
//  CoreDataContext
//
//  Created by JunHeeJo on 2/25/22.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared: CoreDataManager = CoreDataManager()
    private init() {}
    private var container: NSPersistentContainer?
    var mainContext: NSManagedObjectContext {
        guard let context = container?.viewContext else {
            fatalError("Context Error")
        }
        return context
    }
    
    func setup(modelName: String) {
        container = NSPersistentContainer(name: modelName)
        container?.loadPersistentStores { description, error in
            print(description)
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
    }
}
