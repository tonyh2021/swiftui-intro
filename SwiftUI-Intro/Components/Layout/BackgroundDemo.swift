//
//  BackgroundDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-15.
//

import SwiftUI

struct BackgroundDemo: View {
    var body: some View {
        VStack(spacing: 20) {
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
            
            Circle()
                .fill(.pink)
                .frame(width: 100, height: 100)
                .overlay(
                    Text("1")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                )
                .background(
                    Circle()
                        .fill(.purple)
                        .frame(width: 110, height: 110)
                )
            
            Rectangle()
                .frame(width: 100, height: 100)
                .overlay(
                    Rectangle()
                        .fill(.blue)
                        .frame(width: 50, height: 50),
                    alignment: .bottomTrailing
                )
                .background(
                    Rectangle()
                        .fill(.red)
                        .frame(width: 150, height: 150)
                    , alignment: .topLeading
                )
                .padding(.bottom, 100)
            
            Image(systemName: "heart.fill")
                .font(.system(size: 40))
                .foregroundColor(.white)
                .background(
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color(#colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .frame(width: 100, height: 100)
                        .shadow(color: Color(.purple).opacity(0.5), radius: 10, x: 0, y: 10)
                        .overlay(
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 35, height: 35)
                                .overlay(
                                    Text("5")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                )
                                .shadow(color: Color(.purple).opacity(0.5), radius: 10, x: 0, y: 10)
                            , alignment: .bottomTrailing
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
