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
