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
    
    var people: [Person] {
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        //CCI
        //either give us the data we want or stay an empty array
        return (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
    }
    
    // MARK: - CRUD Methods
    func add(name: String) {
        _ = Person(name: name)
        saveToPersistentStore()
    }
    
    func update(person: Person, name: String) {
        person.name = name
        saveToPersistentStore()
    }
    
    func delete(person: Person) {
        CoreDataStack.context.delete(person)
        saveToPersistentStore()
    }
    
    // MARK: - Create Pairs
    func createPairs() -> [[Person]] {
        //CCI
        //.shuffled() lets us easily randomize the array without math
        let randomizedPeople = people.shuffled()
        //ONE array
        var singlePair = [Person]()
        //array OF above arrays
        var allPairs = [[Person]]()
        
        for person in randomizedPeople {
            if singlePair.count == 0 {
                //0 -> 1 person into pair array
                singlePair.append(person)
            } else {
                //1 -> 2 people into array; add to allPairs array
                singlePair.append(person)
                allPairs.append(singlePair)
                //resets singlePair to empty to successfully return to top of forloop
                singlePair = [Person]()
            }
        }
        //this will add person to a pair if odd numbered people
        if singlePair.count != 0 {
            allPairs.append(singlePair)
        }
        return allPairs
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
