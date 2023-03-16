//
//  VStackDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-15.
//

import SwiftUI

struct VStackDemo: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Hello")
            Divider()
            Text("SwiftUI")
        }
        .padding(30)
        .background(Color.green)
    }
}

struct VStackDemo_Previews: PreviewProvider {
    static var previews: some View {
        VStackDemo()
    }
}
