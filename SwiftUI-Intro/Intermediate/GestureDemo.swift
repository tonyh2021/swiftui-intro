//
//  MagnificationGestureDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-17.
//

import SwiftUI

struct GestureDemo: View {
    
    @State private var currentAmount: CGFloat = 0
    @State private var lastAmout: CGFloat = 0
    
    @State private var angle: Angle = Angle(degrees: 0)
    
    @State private var offset: CGSize = .zero
    
    private let startingOffsetY: CGFloat = UIScreen.main.bounds.height - 80
    @State private var currentDragOffsetY: CGFloat = 0
    @State private var targetOffsetY: CGFloat = 0
    
    private let topOffset: CGFloat = 60
    private let dragLimit: CGFloat = 150
    
    var body: some View {
        dragGesture3
    }
}

extension GestureDemo {
    
    /// MagnificationGesture
    private var magnificationGesture2: some View {
        VStack(spacing: 10) {
            HStack {
                Circle()
                    .frame(width: 35, height: 35)
                Text("Hello SwiftUI")
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)
            Rectangle()
                .frame(height: 300)
                .scaleEffect(1 + currentAmount)
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            currentAmount = value - 1
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                currentAmount = 0
                            }
                        }
                )
            HStack {
                Image(systemName: "heart.fill")
                Image(systemName: "text.bubble.fill")
                Spacer()
            }
            .padding(.horizontal)
            .font(.headline)
            Text("This is the caption for my photo!")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
    }
    
    /// MagnificationGesture
    private var magnificationGesture1: some View {
        Text("Hello, SwiftUI!")
            .font(.title)
            .padding(40)
            .background(Color.red.cornerRadius(10))
            .scaleEffect(1 + currentAmount)
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        currentAmount = value - 1
                    }
                    .onEnded { value in
                        lastAmout += currentAmount
                        currentAmount = 0
                    }
            )
    }
    
    
    /// RotationGesture
    private var rotationGesture: some View {
        Text("Hello, SwiftUI!")
            .font(.title)
            .padding(50)
            .background(Color.red.cornerRadius(10))
            .rotationEffect(angle)
            .gesture(
                RotationGesture()
                    .onChanged { value in
                        angle = value
                    }
                    .onEnded { value in
                        withAnimation(.spring()) {
                            angle = Angle(degrees: 0)
                        }
                    }
            )
    }
    
    /// DragGesture
    private var dragGesture: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: 100, height: 100)
            .offset(offset)
            .scaleEffect(getScaleAmount())
            .gesture(
                DragGesture()
                    .onChanged { value in
                        withAnimation(.spring()) {
                            offset = value.translation
                        }
                    }
                    .onEnded { value in
                        withAnimation(.spring()) {
                            offset = .zero
                        }
                    }
            )
    }
    
    
    private var dragGesture2: some View {
        ZStack {
            
            VStack {
                Text("\(offset.width)")
                Spacer()
            }
            
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 300, height: 500)
                .offset(offset)
                .scaleEffect(getScaleAmount())
                .rotationEffect(Angle(degrees: getRotationAmount()))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation(.linear(duration: 0.1)) {
                                offset = value.translation
                            }
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                offset = .zero
                            }
                        }
                )
        }
    }
    
    func getScaleAmount() -> CGFloat {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = abs(offset.width)
        let percentage = currentAmount / max
        return 1.0 - min(percentage, 0.5) * 0.5
    }
    
    func getRotationAmount() -> Double {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = abs(offset.width)
        let percentage = currentAmount / max
        let percentageAsDouble = Double(percentage)
        let maxAngle: Double = 10
        return percentageAsDouble * maxAngle
    }
    
    private var dragGesture3: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            SignUpView()
                .offset(y: startingOffsetY)
                .offset(y: currentDragOffsetY)
                .offset(y: targetOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            var offsetY = value.translation.height
                            if targetOffsetY != 0 && currentDragOffsetY <= -topOffset && offsetY < 0 {
                                offsetY = -topOffset
                            }
                            withAnimation(.spring()) {
                                currentDragOffsetY = offsetY
                            }
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                if currentDragOffsetY < -dragLimit {
                                    targetOffsetY = -startingOffsetY + topOffset
                                } else if targetOffsetY != 0 && currentDragOffsetY > dragLimit {
                                    targetOffsetY = 0
                                }
                                currentDragOffsetY = 0
                            }
                        }
                )
            HStack {
                Text("\(currentDragOffsetY)")
                    .offset(y: 10)
                Text("\(targetOffsetY)")
                    .offset(y: 10)
                    .offset(y: 20)
            }
        }
        .ignoresSafeArea()
    }
}

struct SignUpView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "chevron.up")
                .padding(.top, 20)
            Text("Sign up")
                .font(.headline)
                .fontWeight(.semibold)
            
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud.")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text("CREATE AN ACCOUNT")
                .foregroundColor(.white)
                .font(.headline)
                .padding()
                .padding(.horizontal)
                .background(Color.black.cornerRadius(10))
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(30)
    }
}

struct GestureDemo_Previews: PreviewProvider {
    static var previews: some View {
        GestureDemo()
    }
}
