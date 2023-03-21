//
//  TimerDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-21.
//

import SwiftUI

struct TimerDemo: View {
    
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    // MARK: Current Time, every: 1
    @State private var currentDate: Date = Date()
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
    }
    
    // MARK: Count down, every: 1
    @State private var count: Int = 10
    @State private var finishedText: String? = nil
    
    // MARK: Count down to date, every: 1
    @State private var timeRemaining: String = ""
    private let futureDate = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
    
    // MARK: Animation counter, every: 0.5
    @State private var animationCount: Int = 0
    
    // MARK: Animation counter, every: 3
    @State private var selection: Int = 1
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color.purple, Color.blue]),
                center: .center,
                startRadius: 5,
                endRadius: 500)
            .ignoresSafeArea()
            
            VStack {
//                VStack {
//                    Text(dateFormatter.string(from: currentDate))
//                    Text(finishedText ?? "\(count)")
//                    Text(timeRemaining)
//
//                }
//                .font(.system(size: 80, weight: .semibold, design: .rounded))
//                .foregroundColor(.white)
//                .lineLimit(1)
//                .minimumScaleFactor(0.1)
                
//                HStack(spacing: 15) {
//                    Circle()
//                        .offset(y: animationCount == 1 ? -20 : 0)
//                    Circle()
//                        .offset(y: animationCount == 2 ? -20 : 0)
//                    Circle()
//                        .offset(y: animationCount == 3 ? -20 : 0)
//                }
//                .frame(width: 150)
//                .foregroundColor(.white)
                
                TabView(selection: $selection, content: {
                    Rectangle()
                        .foregroundColor(.red)
                        .tag(1)
                    Rectangle()
                        .foregroundColor(.blue)
                        .tag(2)
                    Rectangle()
                        .foregroundColor(.green)
                        .tag(3)
                    Rectangle()
                        .foregroundColor(.orange)
                        .tag(4)
                    Rectangle()
                        .foregroundColor(.pink)
                        .tag(5)
                })
                .frame(height: 200)
                .tabViewStyle(PageTabViewStyle())
            }
        }
        .onReceive(timer) { value in
            currentDate = value
            
            if count <= 1 {
                finishedText = "Wow!"
            } else {
                count -= 1
            }
            
            updateRemaining()
            
            withAnimation(.easeInOut(duration: 0.5)) {
                animationCount = animationCount == 3 ? 0 : animationCount + 1
            }
            
            withAnimation(.default) {
                selection = selection == 5 ? 1 : selection + 1
            }
        }
    }
    
    func updateRemaining() {
        let remaining = Calendar.current.dateComponents([.minute, .second], from: Date(), to: futureDate)
//        let hour = remaining.hour ?? 0
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        timeRemaining = "\(minute)m:\(second)s"
    }
}

struct TimerDemo_Previews: PreviewProvider {
    static var previews: some View {
        TimerDemo()
    }
}
