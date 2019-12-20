//
//  Person+Convenience.swift
//  PairRandomizer
//
//  Created by Aaron Shackelford on 12/20/19.
//  Copyright © 2019 Aaron Shackelford. All rights reserved.
//

import Foundation
import CoreData

extension Person {
    convenience init(name: String, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
    }
}
