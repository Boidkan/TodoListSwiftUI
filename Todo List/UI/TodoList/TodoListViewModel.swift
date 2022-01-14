//
//  TodoListViewModel.swift
//  Todo List
//
//  Created by Eric Collom on 1/7/22.
//

import Foundation
import Combine
import UIKit

protocol TodoListViewModelCoordinator: AnyObject {
    func todoListDidRequestAddItem()
}

class TodoListViewModel: ObservableObject, DataObserver {
    
    @Published var items: [TodoItem] = []
    private weak var coordinator: TodoListViewModelCoordinator?
    private weak var dataService: TodoDataStore?
    
    init(coordinator: TodoListViewModelCoordinator, dataService: TodoDataStore) {
        self.coordinator = coordinator
        self.dataService = dataService
        self.dataService?.add(observer: self)
        getItems()
    }
    
    func didUpdate(_ items: [TodoItem]) {
        self.items = items
    }
    
    func addItem() {
        coordinator?.todoListDidRequestAddItem()
    }
    
    func getItems() {
        self.dataService?.getTodoItems { items in
            self.items = items
        }
    }
    
    func delete(item: TodoItem) {
        self.dataService?.delete(items: [item])
    }
}

