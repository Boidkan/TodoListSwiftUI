//
//  AddButton.swift
//  Todo List
//
//  Created by Eric Collom on 1/11/22.
//

import SwiftUI

struct AddButton: View {
    
    let addClosure: () -> Void
    
    var body: some View {
        Button(action: addClosure, label: {
            Image(systemName: "plus")
        })
        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        .padding(.zero)
        .onTapGesture {
            addClosure()
        }
    }
}

struct AddButton_Previews: PreviewProvider {
    static var previews: some View {
        AddButton(addClosure: {})
    }
}
