//
//  FrameDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-16.
//

import SwiftUI

struct FrameDemo: View {
    var body: some View {
        Group {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .background(Color.green)
    //            .frame(width: 300, height: 300, alignment: .leading)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
    //            .background(Color.red)
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .background(Color.red)
                .frame(height: 100)
                .background(Color.orange)
                .frame(width: 150)
                .background(Color.purple)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.pink)
                .frame(height: 400)
                .background(Color.green)
                .frame(maxHeight: .infinity, alignment: .top)
                .background(Color.yellow)
        }
    }
}

struct FrameDemo_Previews: PreviewProvider {
    static var previews: some View {
        FrameDemo()
    }
}
