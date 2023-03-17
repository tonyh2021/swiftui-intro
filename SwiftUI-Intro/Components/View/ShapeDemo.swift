//
//  ShapeDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-15.
//

import SwiftUI

struct ShapeDemo: View {
    var body: some View {
        GroupBox {
            Circle()
//                .fill(Color.blue)
//                .foregroundColor(.pink)
            // stroke can not follow after foregroundColor
//                .stroke()
//                .stroke(.green, lineWidth: 10.0)
//                .stroke(.orange, style: StrokeStyle(lineWidth: 20, lineCap: .butt, dash: [5]))
            // trim must before stroke
//                .trim(from: 0.2, to: 1.0)
//                .stroke(.green, lineWidth: 10.0)
                .frame(width: 200, height: 100)
            Ellipse()
                .frame(width: 200, height: 100)
            Rectangle()
                .fill(Color.red)
                .frame(width: 200, height: 100)
            Capsule(style: .continuous)
                .frame(width: 200, height: 100)
            
            RoundedRectangle(cornerRadius: 10)
                .fill(
//                    LinearGradient(gradient: Gradient(colors: [Color.red, Color.green, Color.blue]), startPoint: .top, endPoint: .bottom)
//                    RadialGradient(gradient: Gradient(colors: [Color.red, Color.green, Color.blue]), center: .center, startRadius: 5, endRadius: 200)
                    AngularGradient(gradient: Gradient(colors: [Color.red, Color.green, Color.blue]), center: .topLeading, angle: .degrees(180 + 45))
                )
                .frame(width: 200, height: 100)
        }
    }
}

struct ShapeDemo_Previews: PreviewProvider {
    static var previews: some View {
        ShapeDemo()
    }
}
