//
//  LabelDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-15.
//

import SwiftUI

// UILabel
struct LabelDemo: View {
    var body: some View {
        GroupBox {
            // like Image + Text
            Label("SwiftUI Intro", systemImage: "plus")
            
            // with style
            Label("SwiftUI Intro", systemImage: "plus")
                .font(.headline)
                .foregroundColor(Color.red)
            
            // custom views
            Label {
                Text("SwiftUI Intro")
                    .foregroundColor(Color.blue)
            } icon: {
                Image(systemName: "keyboard")
                    .foregroundColor(Color.green)
            }
            .font(.title)
            
            // custom views
            Label {
                Text("SwiftUI Intro")
            } icon: {
                Circle().frame(width: 20)
            }
            
            // custom style
            Label("SwiftUI Intro", systemImage: "book")
                .labelStyle(BackgroundLabelStyle())
        }
    }
}

struct BackgroundLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        Label(configuration)
            .padding()
            .background(Color.yellow)
    }
}

struct LabelDemo_Previews: PreviewProvider {
    static var previews: some View {
        LabelDemo()
    }
}
