//
//  GeometryPreferenceKeyDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-28.
//

import SwiftUI

struct GeometryPreferenceKeyDemo: View {
    
    @State private var rectSize: CGSize = .zero
    
    var body: some View {
        VStack {
            Text("Hello SwiftUI!")
                .frame(width: rectSize.width, height: rectSize.height)
                .background(Color.blue)
            Spacer()
            HStack {
                Rectangle()
                
                GeometryReader { geo in
                    Rectangle()
                        .updateRectangleGeoSize(geo.size)
                }
                
                Rectangle()
            }
            .frame(height: 55)
        }
        .onPreferenceChange(RectangleGeometryPreferenceKey.self) { value in
            self.rectSize = value
        }
    }
}

struct GeometryPreferenceKeyDemo_Previews: PreviewProvider {
    static var previews: some View {
        GeometryPreferenceKeyDemo()
    }
}

extension View {
    func updateRectangleGeoSize(_ size: CGSize) -> some View {
        preference(key: RectangleGeometryPreferenceKey.self, value: size)
    }
}

struct RectangleGeometryPreferenceKey: PreferenceKey {
    
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
