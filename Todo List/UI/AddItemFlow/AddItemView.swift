//
//  AddItemView.swift
//  Todo List
//
//  Created by Eric Collom on 1/11/22.
//

import SwiftUI



struct AddItemView: View {
    
    var viewModel: AddItemViewModel
    
    @State private var description = ""
    
    var body: some View {
        VStack {
            TextView(text: $description).padding(15)
            Spacer()
            SubmitButton(onHit: {
                if description.count > 0 {
                    viewModel.addTodo(text: description)
                }
            }).padding(.bottom, 25)
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = AddItemViewModel(coordinator: Coordinator(),
                                         dataService: TodoDataStoreService())
        return AddItemView(viewModel: viewModel)
    }
}
