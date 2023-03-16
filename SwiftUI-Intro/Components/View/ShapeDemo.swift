//
//  ShapeDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-15.
//

import SwiftUI

struct ShapeDemo: View {
    var body: some View {
        GroupBox {
            Rectangle()
                .fill(Color.red)
                .frame(width: 200, height: 200)
            Circle()
                .fill(Color.blue)
                .frame(width: 50, height: 50)
            
        }
    }
}

struct ShapeDemo_Previews: PreviewProvider {
    static var previews: some View {
        ShapeDemo()
    }
}
