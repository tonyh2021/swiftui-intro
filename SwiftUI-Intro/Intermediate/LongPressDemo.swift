//
//  LongPressDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-17.
//

import SwiftUI

struct LongPressDemo: View {
    
    @State private var isComplete: Bool = false
    @State private var isSuccess: Bool = false
    
    var body: some View {
        view2
    }
}

extension LongPressDemo {
    private var view1: some View {
        Text(isComplete ? "Complete" : "Not Complete")
            .padding()
            .padding(.horizontal)
            .background(isComplete ? Color.green : Color.gray)
            .cornerRadius(10)
//            .onTapGesture {
//                isComplete.toggle()
//            }
            .onLongPressGesture(minimumDuration: 1, maximumDistance: 50) {
                isComplete.toggle()
            }
    }
    
    private var view2: some View {
        VStack {
            Rectangle()
                .fill(isSuccess ? Color.green : Color.blue)
                .frame(maxWidth: isComplete ? .infinity : 0)
                .frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray)
            
            HStack {
                Text("Click")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .onLongPressGesture(minimumDuration: 3, maximumDistance: 50) { (isPressing) in
                        // call 2 times
                        // 1. start of press
                        // 2. min duration(or cancel)
                        if (isPressing) {
                            withAnimation(.easeInOut(duration: 3)) {
                                isComplete = true
                            }
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                if !isSuccess {
                                    withAnimation(.easeInOut(duration: 1)) {
                                        isComplete = false
                                    }
                                }
                            }
                        }
                    } perform: {
                        // at the min duration
                        withAnimation(.easeInOut) {
                            isSuccess = true
                        }
                    }
                Text("Reset")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .onTapGesture {
                        isComplete = false
                        isSuccess = false
                    }
            }
        }
    }
}

struct LongPressDemo_Previews: PreviewProvider {
    static var previews: some View {
        LongPressDemo()
    }
}
