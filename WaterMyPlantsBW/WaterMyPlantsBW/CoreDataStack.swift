//
//  CoreDataStack.swift
//  WaterMyPlantsBW
//
//  Created by ronald huston jr on 8/23/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//

import UIKit
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Plant")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("failed to load persistent stores: \(error)")
            }
        }
        //  need to add a data model for this to work
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    func save(context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        context.performAndWait {
            do {
                try context.save()
            } catch {
                NSLog("error saving to persistent store: \(error)")
                context.reset()
            }
        }
    }
}
