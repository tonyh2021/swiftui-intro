//
//  ButtonDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-15.
//

import SwiftUI

// UIButton
struct ButtonDemo: View {
    var body: some View {
        GroupBox {
            Button(
                action: {
                    // do something
                },
                label: { Image("swiftui") }
            )
        }
    }
}

struct ButtonDemo_Previews: PreviewProvider {
    static var previews: some View {
        ButtonDemo()
    }
}
