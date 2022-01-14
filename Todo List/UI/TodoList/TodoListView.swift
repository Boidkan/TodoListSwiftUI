//
//  ContentView.swift
//  Todo List
//
//  Created by Eric Collom on 1/7/22.
//

import SwiftUI
import Combine

struct TodoListView: View {
    
    @ObservedObject var viewModel: TodoListViewModel
    
    var body: some View {
        List($viewModel.items, id: \.self) { item in
            ListItem(todoItem: item.wrappedValue) {
                viewModel.delete(item: item.wrappedValue)
            }
        }
        Spacer()
        AddButton(addClosure: viewModel.addItem)
            .padding(.bottom, 25)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = TodoListViewModel(coordinator: Coordinator(), dataService: TodoDataStoreService())
        return TodoListView(viewModel: viewModel)
    }
}
