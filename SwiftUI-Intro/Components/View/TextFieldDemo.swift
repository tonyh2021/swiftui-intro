//
//  TextFieldDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-15.
//

import SwiftUI

// UITextField
struct TextFieldDemo: View {
    // usually go with state
    @State var name: String = "Tony" //create State
    @State var password: String = ""
    
    var body: some View {
        GroupBox {
            TextField("Username", text: $name)
                .textFieldStyle(.roundedBorder) // adds border
            
            SecureField("Password", text:$password) // passing it to bind
                .textFieldStyle(.roundedBorder) // adds border
        }
    }
}

struct TextFieldDemo_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldDemo()
    }
}
