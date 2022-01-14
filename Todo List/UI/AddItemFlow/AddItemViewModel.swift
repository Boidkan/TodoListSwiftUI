//
//  AddItemViewModel.swift
//  Todo List
//
//  Created by Eric Collom on 1/13/22.
//

import Foundation

protocol AddItemViewModelCoordinator: AnyObject {
    func addItemDidRequestDismiss()
}

class AddItemViewModel {

    private weak var dataService: TodoDataStore?
    private weak var coordinator: AddItemViewModelCoordinator?
    
    init(coordinator: AddItemViewModelCoordinator, dataService: TodoDataStore) {
        self.dataService = dataService
        self.coordinator = coordinator
    }
    
    func addTodo(text: String) {
        dataService?.save(item: TodoItem(description: text, isCompleted: false))
        coordinator?.addItemDidRequestDismiss()
    }
}
