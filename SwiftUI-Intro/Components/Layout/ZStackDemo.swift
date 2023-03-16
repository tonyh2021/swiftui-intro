//
//  ZStackDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-15.
//

import SwiftUI

struct ZStackDemo: View {
    var body: some View {
        ZStack(alignment: .top) {
            Image("swiftui")
            Text("SwiftUI")
                .foregroundColor(Color.white)
                .bold()
        }
        .padding(10)
        .background(Color.black)
    }
}

struct ZStackDemo_Previews: PreviewProvider {
    static var previews: some View {
        ZStackDemo()
    }
}
