//
//  CustomizeButtonStyleDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-28.
//

import SwiftUI

struct PressableButtonStyle: ButtonStyle {
    
    let scale: CGFloat
    
    init(scale: CGFloat) {
        self.scale = scale
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
//            .opacity(configuration.isPressed ? 0.9 : 1)
//            .brightness(configuration.isPressed ? 0.05 : 0)
            .scaleEffect(configuration.isPressed ? scale : 1.0)
    }
}

extension View {
    func withPressableStyle(_ scale: CGFloat = 0.9) -> some View {
        buttonStyle(PressableButtonStyle(scale: scale))
    }
}

struct CustomizeButtonStyleDemo: View {
    var body: some View {
        Button {
            print("tapped...")
            
        } label: {
            Text("Tap me...")
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
                .shadow(color: Color.blue, radius: 10, y: 10)
        }
        .withPressableStyle(1.2)
        .padding(40)
    }
}

struct CustomizeButtonStyleDemo_Previews: PreviewProvider {
    static var previews: some View {
        CustomizeButtonStyleDemo()
    }
}
