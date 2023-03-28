//
//  CustomShapesDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-28.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let horizontalOffset: CGFloat = rect.width * 0.2
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}

struct Trapezoid: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let horizontalOffset: CGFloat = rect.width * 0.2
            path.move(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.minY))
        }
    }
}

struct CustomShapesDemo: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Triangle()
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
                Trapezoid()
                    .frame(width: 200, height: 200)
                Diamond()
                    .frame(width: 200, height: 200)
                Image(systemName: "apple.logo")
                    .resizable()
                    .scaledToFill()
                    .clipShape(Triangle())
                    .frame(width: 200, height: 200)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct CustomShapesDemo_Previews: PreviewProvider {
    static var previews: some View {
        CustomShapesDemo()
    }
}
