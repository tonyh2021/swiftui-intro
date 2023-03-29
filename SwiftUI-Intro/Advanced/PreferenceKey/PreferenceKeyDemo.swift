//
//  PreferenceKeyDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-17.
//

import SwiftUI

struct PreferenceKeyDemo: View {
    
    @State private var text: String = "Hello SwiftUI!"
    
    var body: some View {
        NavigationView {
            VStack {
                SecondaryScreen(text: text)
                    .navigationTitle("Navigation Title")
            }
        }
        .onPreferenceChange(CustomTitlePreferenceKey.self) { value in
            self.text = value
        }
    }
}

extension View {
    
    func customTitle(_ text: String) -> some View {
        preference(key:CustomTitlePreferenceKey.self, value: text)
    }
}

struct SecondaryScreen: View {
    
    let text: String
    
    @State private var newText: String = "Old data."
    
    var body: some View {
        Text(text)
            .onTapGesture {
                newText = "New data from database."
            }
            .customTitle(newText)
    }
}

struct PreferenceKeyDemo_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceKeyDemo()
    }
}

struct CustomTitlePreferenceKey: PreferenceKey {
    
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}
