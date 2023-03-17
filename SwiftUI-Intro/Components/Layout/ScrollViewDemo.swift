//
//  ScrollViewDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-15.
//

import SwiftUI

// UIScrollView
struct ScrollViewDemo: View {
    
    var body: some View {
        scrollView2
    }
}

extension ScrollViewDemo {
    private var scrollView1: some View {
        ScrollView {
            // VStack or LazyVStack
            LazyVStack(spacing: 20) {
                ForEach(0..<20) { index in
                    SampleRow(id: index)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .font(.largeTitle)
    }
    
    private var scrollView2: some View {
        ScrollView {
            // VStack or LazyVStack
            LazyVStack() {
                ForEach(0..<100) { index in
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        LazyHStack {
                            ForEach(0..<20) { index in
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(.white)
                                    .frame(width: 200, height: 150)
                                    .shadow(radius: 10)
                                    .padding()
                            }
                        }
                    })
                }
            }
            .frame(maxWidth: .infinity)
        }
        .font(.largeTitle)
    }
}

struct SampleRow: View {
    let id: Int

    var body: some View {
        Text("\(id)")
            .foregroundColor(.white)
            .frame(width: 100, height: 100)
            .background(Color.pink)
            .cornerRadius(50)
    }

    init(id: Int) {
        print("Loading row \(id)")
        self.id = id
    }
}

struct ScrollViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewDemo()
    }
}
