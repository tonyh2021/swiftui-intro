//
//  GeometryReaderDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-17.
//

import SwiftUI

/// use its size and coordinates to determine a child view’s layout
/// .coordinateSpace(name: "Custom")

struct GeometryReaderDemo: View {
    
    @State private var rating: Int = 0
    
    var body: some View {
        starDemo
    }
}

extension GeometryReaderDemo {
    
    private var geometryReaderDemo2: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack {
                ForEach(0..<20, id: \.self) { index in
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 20)
                            .rotation3DEffect(Angle(degrees: getPercentage(geo: geometry) * 40), axis: (x: 0, y: 1, z: 0))
                    }
                    .frame(width: 300, height: 250)
                    .padding()
                }
            }
        })
    }
    
    func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return Double(1 - (currentX / maxDistance))
    }
    
    private var geometryReaderDemo1: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: geometry.size.width * 0.666)
                Rectangle()
                    .fill(Color.blue)
            }
            .ignoresSafeArea()
        }
    }
    
    private var starDemo: some View {
        ZStack {
            starView
                .overlay(overlayView.mask(starView))
        }
    }
    
    private var overlayView: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
//                    .foregroundColor(.yellow)
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing)
                    )
                    .frame(width: CGFloat(rating) / 5 * geometry.size.width)
            }
        }
        .allowsHitTesting(false)
    }
    
    private var starView: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(Color.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            rating = index
                        }
                    }
            }
        }
    }
}

struct GeometryReaderDemo_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderDemo()
    }
}
