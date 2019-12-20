//
//  CoreDataStack.swift
//  PairRandomizer
//
//  Created by Aaron Shackelford on 12/20/19.
//  Copyright © 2019 Aaron Shackelford. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PairRandomizer")
        container.loadPersistentStores { (store, error) in
            if let error = error as NSError? {
                print("ERROR loading from persistent store: Double back to CDS file.")
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    static var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    // MARK: - CoreData Persistence
    static func saveMOC() {
        let context = CoreDataStack.context
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
}
