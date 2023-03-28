//
//  CustomCurvesDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-28.
//

import SwiftUI

struct ArcSample: Shape {
    
    func path(in rect: CGRect) -> Path {
        Path {
            $0.move(to: CGPoint(x: rect.maxX, y: rect.midY))
            $0.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.height / 2,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 40),
                clockwise: true)
        }
    }
}

struct ShapeWithArc: Shape {
    
    func path(in rect: CGRect) -> Path {
        Path {
            // top left
            $0.move(to: CGPoint(x: rect.minX, y: rect.minY))
            // top right
            $0.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            // mid right
            $0.addLine(to: CGPoint(x: rect.maxX, y: rect.midY - 65))
            // bottom
            $0.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY - 65),
                radius: rect.height / 2,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 180),
                clockwise: false)
//            $0.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            // mid left
            $0.addLine(to: CGPoint(x: rect.minX, y: rect.midY - 65))
            // orignal point
            $0.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        }
    }
}

struct QuadSample: Shape {
    func path(in rect: CGRect) -> Path {
        Path {
            $0.move(to: .zero)
            $0.addQuadCurve(
                to: CGPoint(x: rect.maxX, y: rect.maxY),
                control: CGPoint(x: rect.minX, y: rect.maxY))
        }
    }
}

struct WaterSample: Shape {
    func path(in rect: CGRect) -> Path {
        Path {
            $0.move(to:  CGPoint(x: rect.minX, y: rect.midY))
            $0.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.midY),
                control: CGPoint(x: rect.width * 0.25, y: rect.height * 0.4))
            $0.addQuadCurve(
                to: CGPoint(x: rect.maxX, y: rect.midY),
                control: CGPoint(x: rect.width * 0.75, y: rect.height * 0.6))
            $0.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            $0.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            $0.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        }
    }
}

struct CustomCurvesDemo: View {
    var body: some View {
        WaterSample()
//            .stroke(lineWidth: 5)
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue, Color.green]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing)
            )
            .ignoresSafeArea()
//            .frame(width: 200, height: 200)
    }
}

struct CustomCurvesDemo_Previews: PreviewProvider {
    static var previews: some View {
        CustomCurvesDemo()
    }
}
