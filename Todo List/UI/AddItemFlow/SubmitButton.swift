//
//  SubmitButton.swift
//  Todo List
//
//  Created by Eric Collom on 1/12/22.
//

import SwiftUI

struct SubmitButton: View {
    
    var onHit: () -> Void
    
    var body: some View {
        Button("Submit") {
            onHit()
        }
        .font(.title3)
        .padding(.zero)
    }
}

struct SubmittButton_Previews: PreviewProvider {
    static var previews: some View {
        SubmitButton(onHit: {})
    }
}
