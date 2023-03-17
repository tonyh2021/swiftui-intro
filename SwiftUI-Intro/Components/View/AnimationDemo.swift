//
//  AnimationDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-16.
//

import SwiftUI

struct AnimationDemo: View {
    
    @State private var isAnimated: Bool = false
    
    private let timing: Double = 10
    
    var body: some View {
        animationDemo2
    }
}

extension AnimationDemo {
    private var animationDemo1: some View {
        VStack {
            Button {
                print("tapped...")
                withAnimation(
                    Animation.default.delay(1.0)
//                    Animation.default.repeatCount(5, autoreverses: true)
//                    Animation.default.repeatForever(autoreverses: true)
                ) {
                    isAnimated.toggle()
                }
            } label: {
                Text("Tap me to animate")
            }
            Spacer()
            RoundedRectangle(cornerRadius: isAnimated ? 50 : 25)
                .fill(isAnimated ? Color.red : Color.green)
                .frame(width: isAnimated ? 100 : 300,
                       height: isAnimated ? 100 : 300)
                .rotationEffect(Angle(degrees: isAnimated ? 360 : 0))
                .offset(y: isAnimated ? 300 : 0)
            Spacer()
        }
    }
    
    private var animationDemo2: some View {
        VStack {
            Button {
                isAnimated.toggle()
            } label: {
                Text("Tap me to animate")
            }
            RoundedRectangle(cornerRadius: 20)
                .fill(isAnimated ? Color.red : Color.green)
                .frame(width: isAnimated ? 350 : 50,
                       height: 100)
                .animation(.linear(duration: timing))
            RoundedRectangle(cornerRadius: 20)
                .fill(isAnimated ? Color.red : Color.green)
                .frame(width: isAnimated ? 350 : 50,
                       height: 100)
                .animation(.easeIn(duration: timing))
            RoundedRectangle(cornerRadius: 20)
                .fill(isAnimated ? Color.red : Color.green)
                .frame(width: isAnimated ? 350 : 50,
                       height: 100)
                .animation(.easeInOut(duration: timing))
            RoundedRectangle(cornerRadius: 20)
                .fill(isAnimated ? Color.red : Color.green)
                .frame(width: isAnimated ? 350 : 50,
                       height: 100)
                .animation(.easeOut(duration: timing))
            
            RoundedRectangle(cornerRadius: 20)
                .fill(isAnimated ? Color.red : Color.green)
                .frame(width: isAnimated ? 350 : 50,
                       height: 100)
                .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.5))
        }
    }
}

struct AnimationDemo_Previews: PreviewProvider {
    static var previews: some View {
        AnimationDemo()
    }
}
