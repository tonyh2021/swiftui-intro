//
//  AnyTransitionDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-28.
//

import SwiftUI

struct RotateViewModifier: ViewModifier {
    
    let rotation: Double
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: rotation))
            .offset(x: rotation != 0 ? UIScreen.main.bounds.width : 0,
                    y: rotation != 0 ? UIScreen.main.bounds.height : 0)
    }
}

extension AnyTransition {
    
    static var rotating: AnyTransition {
        .modifier(
            active: RotateViewModifier(rotation: 180),
            identity: RotateViewModifier(rotation: 0))
    }
    
    static func rotating(rotation: Double) -> AnyTransition {
        .modifier(
            active: RotateViewModifier(rotation: rotation),
            identity: RotateViewModifier(rotation: 0))
    }
    
    static var rotatingOn: AnyTransition {
        .asymmetric(
            insertion: .rotating,
            removal: .move(edge: .leading))
    }
}

struct AnyTransitionDemo: View {
    
    @State private var showRectangle: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            if showRectangle {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 250, height: 350)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .transition(AnyTransition.rotating.animation(.easeInOut))
//                    .transition(.rotating(rotation: 1080))
                    .transition(.rotatingOn)
            }
            
            Spacer()
            
            Text("Click me!")
                .withButtonViewModifierFormatting()
                .padding(.horizontal, 40)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        showRectangle.toggle()
                    }
                }
        }
    }
}

struct AnyTransitionDemo_Previews: PreviewProvider {
    static var previews: some View {
        AnyTransitionDemo()
    }
}
