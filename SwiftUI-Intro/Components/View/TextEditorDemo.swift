//
//  TextEditorDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-15.
//

import SwiftUI

// UITextView
struct TextEditorDemo: View {
    
    @State var text: String = "SwiftUI Inrtoductions."
    @State var text2: String = "SwiftUI Inrtoductions. \nSwiftUI Inrtoductions. \nSwiftUI Inrtoductions."
    
    var body: some View {
        GroupBox {
            TextEditor(text: $text)
                .padding()
                .font(.headline)
                .foregroundColor(Color.red)
            
            TextEditor(text: $text2)
                .padding()
                .font(.headline)
                .foregroundColor(Color.red)
                .multilineTextAlignment(.center)
                .lineSpacing(10.0)
            
            // event
            TextEditor(text: $text2)
                .onChange(of: text, perform: { value in
                    print("Text: \(text)")
                })
            
            // Size
            TextEditor(text: $text2)
                .frame(minWidth: 0, maxWidth: 200, minHeight: 0, maxHeight: 50)
                .border(Color.blue)
        }
    }
}

struct TextEditorDemo_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorDemo()
    }
}
