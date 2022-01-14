//
//  TodoItem.swift
//  Todo List
//
//  Created by Eric Collom on 1/7/22.
//

import Foundation
import CoreData

struct TodoItem: Hashable {
    var description: String
    var isCompleted: Bool
    var id: UUID?
}

extension TodoItem {
    init(entity: TodoItemEntity) {
        self.description = entity.descriptionText ?? ""
        self.isCompleted = entity.isCompleted
        self.id = entity.uuid
    }
}

extension TodoItemEntity {
    class func create(from item: TodoItem, into context: NSManagedObjectContext) {
        
        let entity = TodoItemEntity(context: context)
        entity.descriptionText = item.description
        entity.isCompleted = item.isCompleted
        entity.uuid = UUID()
        
        do {
            try context.save()
        } catch let error {
            print("Failed to save todo item \(error.localizedDescription)")
        }
    }
}
