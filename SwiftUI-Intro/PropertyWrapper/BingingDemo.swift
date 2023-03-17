//
//  BingingDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-16.
//

import SwiftUI

struct BingingDemo: View {
    
    @State private var backgroundColor: Color = Color.green
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            ButtonView(backgroundColor: $backgroundColor)
        }
    }
}

struct ButtonView: View {
    
    /// 1. want to change state of parent view
    /// 2. no init value
    
    @Binding var backgroundColor: Color
    
    var body: some View {
        Button {
            print("tapped...")
            backgroundColor = Color.orange
        } label: {
            Text("Tap me...")
                .foregroundColor(.white)
                .padding()
                .padding(.horizontal)
                .background(Color.blue)
                .cornerRadius(10)
        }
    }
}

struct BingingDemo_Previews: PreviewProvider {
    static var previews: some View {
        BingingDemo()
    }
}
