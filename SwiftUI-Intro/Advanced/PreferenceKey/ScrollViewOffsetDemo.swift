//
//  ScrollViewOffsetDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-28.
//

import SwiftUI

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension View {
    func updateScrollViewOffset(_ offset: CGFloat) -> some View {
        preference(key: ScrollViewOffsetPreferenceKey.self, value: offset)
    }
    
    func onScrollViewOffset(handler: @escaping (_ value: CGFloat) -> Void) -> some View {
        self.background(
            GeometryReader { geo in
                Text("")
                    .updateScrollViewOffset(geo.frame(in: .global).minY)
            }
        )
        .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
            handler(value)
        }
    }
}

struct ScrollViewOffsetDemo: View {
    
    let title: String = "New Title"
    @State private var scrollViewOffset: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack {
                titleLayer
                    .opacity(Double(scrollViewOffset) / 64.0)
                    .onScrollViewOffset { value in
                        scrollViewOffset = value
                    }
                contentLayer
            }
            .padding()
        }
        .overlay(Text("\(scrollViewOffset)"))
        .overlay(navBarLayer
            .opacity(scrollViewOffset < 40 ? 1.0 : 0.0)
                 , alignment: .top)
    }
}

extension ScrollViewOffsetDemo {
    
    private var titleLayer: some View {
        Text(title)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var contentLayer: some View {
        ForEach(0..<100) { index in
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.red.opacity(0.3))
                .frame(width: 300, height: 200)
        }
    }
    
    private var navBarLayer: some View {
        Text(title)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color.blue)
    }
}

struct ScrollViewOffsetDemo_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewOffsetDemo()
    }
}
