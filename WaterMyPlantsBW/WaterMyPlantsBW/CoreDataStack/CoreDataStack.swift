//
//  CoreDataStack.swift
//  WaterMyPlantsBW
//
//  Created by Clayton Watkins on 8/25/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    // Static makes it a class property
    static let shared = CoreDataStack()
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Tasks")
        container.loadPersistentStores { (_, error) in
            if let error = error{
                fatalError("Failed to load persistence stores: \(error)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    func save(context: NSManagedObjectContext = CoreDataStack.shared.mainContext) throws {
        var error: Error?
        context.performAndWait {
            do{
                try context.save()
            } catch let saveError {
                error = saveError
            }
        }
        if let error = error { throw error }
    }
    
}