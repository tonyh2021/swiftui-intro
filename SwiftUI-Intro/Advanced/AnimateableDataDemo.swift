//
//  AnimateableDataDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-28.
//

import SwiftUI

struct AnimateableDataDemo: View {
    
    @State private var animate: Bool = false
    
    var body: some View {
        ZStack {
//            RoundedRectangle(cornerRadius: animate ? 60 : 0)
//                .frame(width: 250, height: 250)
            
//            RectangleWithSingleCornerAnimation(cornerRadius: animate ? 60 : 0)
//                .frame(width: 250, height: 250)
            
            Pacman(offsetDegree: animate ? 20 : 0)
                .frame(width: 250, height: 250)
        }
        .onAppear {
            withAnimation(Animation.easeInOut.repeatForever()) {
                animate.toggle()
            }
        }
    }
}

struct RectangleWithSingleCornerAnimation: Shape {
    
    var cornerRadius: CGFloat
    
    var animatableData: CGFloat {
        get { cornerRadius }
        set { cornerRadius = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        Path {
            $0.move(to: .zero)
            $0.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            $0.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
            $0.addArc(
                center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius),
                radius: cornerRadius,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 90),
                clockwise: false)
            $0.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY))
            $0.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            $0.addLine(to: .zero)
        }
    }
}

struct Pacman: Shape {
    
    var offsetDegree: Double
    
    var animatableData: Double {
        get { offsetDegree }
        set { offsetDegree = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        Path {
            $0.move(to: CGPoint(x: rect.midX, y: rect.minY))
            $0.addArc(
                center: CGPoint(x: rect.midX, y: rect.minY),
                radius: rect.width / 2,
                startAngle: Angle(degrees: offsetDegree),
                endAngle: Angle(degrees: 360 - offsetDegree),
                clockwise: false)
        }
    }
}

struct AnimateableDataDemo_Previews: PreviewProvider {
    static var previews: some View {
        AnimateableDataDemo()
    }
}
