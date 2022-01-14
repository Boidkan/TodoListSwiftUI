//
//  ListItem.swift
//  Todo List
//
//  Created by Eric Collom on 1/11/22.
//

import SwiftUI

struct ListItem: View {
    
    var todoItem: TodoItem
    var deleteAction: () -> Void
    
    var body: some View {
        HStack {
            Text(todoItem.description).font(.title2)
                .onTapGesture {} // Need this to prevent cell tap from deleting Todo
            Spacer()
            Button(action: deleteAction, label: {
                Image(systemName: "trash")
            })
                .foregroundColor(.red)
        }
    }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        let item = TodoItem(description: "Test", isCompleted: false)
        return ListItem(todoItem: item, deleteAction: {})
    }
}
