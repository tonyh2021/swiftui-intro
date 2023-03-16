//
//  BackgroundDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-15.
//

import SwiftUI

struct BackgroundDemo: View {
    var body: some View {
        GroupBox {
            Text("Hello SwiftUI")
                .font(.largeTitle)
                .background(
                    Image("swiftui")
                        .resizable()
                        .frame(width: 100, height: 100)
                )
            
            Text("Hello SwiftUI")
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [.white, .red, .black]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
        }
    }
}

struct BackgroundDemo_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundDemo()
    }
}
