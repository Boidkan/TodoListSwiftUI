//
//  PersistentContainer.swift
//  Todo List
//
//  Created by Eric Collom on 1/7/22.
//

import Foundation
import CoreData


class PersistentContainer: NSPersistentContainer {
    
    func saveContext(backgroundContext: NSManagedObjectContext? = nil) {
        let context = backgroundContext ?? viewContext
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
    }
}
