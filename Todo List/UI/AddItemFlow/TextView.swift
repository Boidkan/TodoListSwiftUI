//
//  TextView.swift
//  Todo List
//
//  Created by Eric Collom on 1/12/22.
//

import Foundation
import SwiftUI

struct TextView: UIViewRepresentable {
    
    func makeCoordinator() -> Coordinator {
        Coordinator($text)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>
        var didBecomeFirstResponder = false

        init(_ text: Binding<String>) {
            self.text = text
        }

        func textViewDidChange(_ textView: UITextView) {
            self.text.wrappedValue = textView.text
        }
    }
    
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.contentInset = .zero
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        if !context.coordinator.didBecomeFirstResponder  {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
}
