//
//  UIViewRepresentableDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-28.
//

import SwiftUI

// Convert a UIView from UIKit to SwiftUI
struct UIViewRepresentableDemo: View {
    
    @State private var text: String = "Hello SwiftUI!"
    
    var body: some View {
        VStack {
            Text(text)
                .frame(height: 55)
            HStack {
                Text("SwiftUI: ")
                TextField("Type here...", text: $text)
                    .frame(height: 55)
                    .background(Color.gray)
            }
            HStack {
                Text("UIKit: ")
                UITextFieldViewRepresentable(
                    text: $text,
                    placeholder: "Type here...")
                .updatePlaceholder("New holder!")
                .frame(height: 55)
                .background(Color.gray)
                    
            }
        }
    }
}

struct UIViewRepresentableDemo_Previews: PreviewProvider {
    static var previews: some View {
        UIViewRepresentableDemo()
    }
}

struct UITextFieldViewRepresentable: UIViewRepresentable {
    
    @Binding var text: String
    
    var placeholder: String
    let placeholderColor: UIColor
    
    init(text: Binding<String>, placeholder: String, placeholderColor: UIColor = UIColor.green) {
        self._text = text
        self.placeholder = placeholder
        self.placeholderColor = placeholderColor
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = getTextField()
        textField.delegate = context.coordinator
        return textField
    }
    
    // SwiftUI -> UIKit
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    // UIKit -> SwiftUI
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            self._text = text
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
        
    }
    
    private func getTextField() -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: placeholderColor
            ])
        return textField
    }
    
    func updatePlaceholder(_ text: String) -> UITextFieldViewRepresentable {
        var viewRepresentable = self
        viewRepresentable.placeholder = text
        return viewRepresentable
    }
}

struct BasicUIViewRepresentable: UIViewRepresentable {
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
