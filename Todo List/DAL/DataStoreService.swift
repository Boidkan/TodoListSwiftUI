//
//  DataStoreService.swift
//  Todo List
//
//  Created by Eric Collom on 1/7/22.
//

import Foundation
import CoreData


protocol TodoDataStore: AnyObject {
//    func getTodoItems() -> [TodoItem]
    func getTodoItems(completion: @escaping ([TodoItem]) -> Void)
    func save(item: TodoItem)
    func delete(items: [TodoItem])
    func add(observer: DataObserver)
    func remove(observer: DataObserver)
}

protocol DataObserver: AnyObject {
    func didUpdate(_ items: [TodoItem])
}

class TodoDataStoreService: TodoDataStore {
    
    private var observers: [DataObserver] = []
    
    func add(observer: DataObserver) {
        observers.append(observer)
    }
    
    func remove(observer: DataObserver) {
        observers.removeAll { $0 === observer }
    }
    
    private func notifyObservers() {
        getTodoItems { items in
            DispatchQueue.main.async {
                self.observers.forEach { $0.didUpdate(items) }
            }
        }
    }
    
    func delete(items: [TodoItem]) {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "TodoItemEntity")
        let ids = items.map { $0.id }
        
        fetch.predicate = NSPredicate(format: "uuid IN %@", ids)
        fetch.resultType = .managedObjectIDResultType
        
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        request.resultType = .resultTypeObjectIDs
        let context = newBackgroundContext
        
        persistentContainer.performBackgroundTask { moc in
            do {
                let deleteResult = try moc.execute(request) as? NSBatchDeleteResult
                
                if let objectIDs = deleteResult?.result as? [NSManagedObjectID] {
                    NSManagedObjectContext.mergeChanges(fromRemoteContextSave: [NSDeletedObjectsKey: objectIDs],
                                                        into: [context])
                }
                
                self.notifyObservers()
            } catch let error {
                print("Failed to delete with error: \(error.localizedDescription)")
            }
        }
    }
    
    func getTodoItems(completion: @escaping ([TodoItem]) -> Void){
        
        let request: NSFetchRequest<TodoItemEntity> = TodoItemEntity.fetchRequest()

        persistentContainer.performBackgroundTask { moc in
            do {
                let entities = try moc.fetch(request)
                let items = entities.map { TodoItem(entity: $0) }
                completion(items)
            } catch let error {
                print("Failed to fetch with error: \(error.localizedDescription)")
            }
        }
    }
    
    func save(item: TodoItem) {
        TodoItemEntity.create(from: item, into: newBackgroundContext)
        notifyObservers()
    }
    
    private var newBackgroundContext: NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
    private lazy var persistentContainer: PersistentContainer = {
        let container = PersistentContainer(name: "DataModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
}
