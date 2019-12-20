//
//  PersonController.swift
//  PairRandomizer
//
//  Created by Aaron Shackelford on 12/20/19.
//  Copyright © 2019 Aaron Shackelford. All rights reserved.
//

import Foundation
import CoreData

class PersonController {
    
    // MARK: - Properties
    static var shared = PersonController()
    
    // MARK: - CRUD Methods
    func addPerson(name: String) {
        _ = Person(name: name)
        saveToPersistentStore()
    }
    
    func updatePerson(person: Person, name: String) {
        person.name = name
        saveToPersistentStore()
    }
    
    // MARK: - Data Persistence
    func saveToPersistentStore() {
        let moc = CoreDataStack.context
        do {
            try moc.save()
        } catch {
            print("ERROR saving to persistent store: \(error.localizedDescription)")
        }
    }
}
