//
//  LinkDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-15.
//

import SwiftUI

struct LinkDemo: View {
    var body: some View {
        GroupBox {
            Link("SwiftUI Intro", destination: URL(string: "https://github.com/tonyh2021/swiftui-intro")!)
            
            // customize
            Link("SwiftUI Intro", destination: URL(string: "https://github.com/tonyh2021/swiftui-intro")!)
                .font(.largeTitle)
                    .foregroundColor(.red)
            
            // custom view
            Link(destination: URL(string: "https://github.com/tonyh2021/swiftui-intro")!) {
                VStack {
                    Image(systemName: "paperplane")
                        .font(.largeTitle)
                    Text("SwiftUI!")
                }
            }
        }
    }
}

struct LinkDemo_Previews: PreviewProvider {
    static var previews: some View {
        LinkDemo()
    }
}
