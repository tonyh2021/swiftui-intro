//
//  ViewModifierDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-28.
//

import SwiftUI

struct ButtonViewModifier: ViewModifier {
    
    let backgroundColor: Color

    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(10)
            .shadow(radius: 10)
    }
}

extension View {
    func withButtonViewModifierFormatting(_ backgroundColor: Color = .blue) -> some View {
        modifier(ButtonViewModifier(backgroundColor: backgroundColor))
    }
}

struct ViewModifierDemo: View {
    var body: some View {
        VStack(spacing: 15) {
            Text("Hello, World!")
                .font(.headline)
                .modifier(ButtonViewModifier(backgroundColor: .blue))
            
            Text("Hello, SwiftUI!")
                .font(.title)
                .withButtonViewModifierFormatting()
            
            Text("Hello, SwiftUI!")
                .font(.title)
                .withButtonViewModifierFormatting(.red)
        }
        .padding()
    }
}

struct ViewModifierDemo_Previews: PreviewProvider {
    static var previews: some View {
        ViewModifierDemo()
    }
}
