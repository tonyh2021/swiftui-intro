//
//  ImageDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-15.
//

import SwiftUI

// UIImageView
struct ImageDemo: View {
    var body: some View {
        GroupBox {
            Image("swiftui")
            Image(systemName: "cloud.fill")
                .foregroundColor(.red)
                .font(.largeTitle)
            
            Image("swiftui")
                .resizable() //it will sized so that it fills all the available space
                .aspectRatio(contentMode: .fill)
                .padding(.bottom)
        }
    }
}

struct ImageDemo_Previews: PreviewProvider {
    static var previews: some View {
        ImageDemo()
    }
}
