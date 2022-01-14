//
//  Coordinator.swift
//  Todo List
//
//  Created by Eric Collom on 1/11/22.
//

import UIKit
import SwiftUI

class Coordinator {
    
    var navigationController: UINavigationController!
    private var dataService: TodoDataStore = TodoDataStoreService()
    
    func start() {
        let viewModel = TodoListViewModel(coordinator: self, dataService: dataService)
        let todoListView = TodoListView(viewModel: viewModel)
        navigationController = UINavigationController()
        let vc = UIHostingController(rootView: todoListView)
        vc.title = "Todo!"
        navigationController.pushViewController(vc, animated: false)
    }
}

extension Coordinator: TodoListViewModelCoordinator {
    func todoListDidRequestAddItem() {
        let viewModel = AddItemViewModel(coordinator: self, dataService: dataService)
        let controller = UIHostingController(rootView: AddItemView(viewModel: viewModel))
        controller.title = "Add Item"
        navigationController.pushViewController(controller, animated: true)
    }
}

extension Coordinator: AddItemViewModelCoordinator {
    func addItemDidRequestDismiss() {
        navigationController.popViewController(animated: true)
    }
}
