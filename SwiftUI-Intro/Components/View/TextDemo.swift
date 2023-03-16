//
//  TextDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-15.
//

import SwiftUI

// UILabel
struct TextDemo: View {
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    var body: some View {
        GroupBox {
            Text("Hello, SwiftUI!")
            
            Text("Hello, SwiftUI!")
                .font(.title)
                .padding(10.0)
                .background(Color.blue)
                .foregroundColor(Color.white)
                .cornerRadius(18.0)
            
            // format text inside
            Text("Date: \(Date(), formatter: Self.dateFormatter)")
        }
    }
}

struct TextDemo_Previews: PreviewProvider {
    static var previews: some View {
        TextDemo()
    }
}
