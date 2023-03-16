//
//  HStackDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-15.
//

import SwiftUI

struct HStackDemo: View {
    
    @State private var alignmentProp: VerticalAlignment = .center
    
    @State private var redPriority: CGFloat = 1.0
    @State private var bluePriority: CGFloat = 1.0
    @State private var greenPriority: CGFloat = 1.0
    
    var body: some View {
        VStack {
            HStack {
                Text("Hello")
                    .font(.largeTitle)
                Text("SwiftUI")
                    .font(.title3)
                
                HStack {
                    Text("H")
                        .font(.system(size: 26))
                    Text("E")
                        .font(.system(size: 22))
                    Text("L")
                        .font(.system(size: 18))
                }
                
                Group {
                    Text("L")
                        .font(.system(size: 14))
                    Text("O")
                        .font(.system(size: 10))
                    Text("!")
                        .font(.system(size: 6))
                }
            }
            .padding()
            .border(Color.orange)
            
            // MARK: alignment
            HStack (alignment: alignmentProp) {
                VStack {
                    Text("Hello")
                    Text("SwiftUI")
                }.font(.largeTitle)
                
                HStack {
                    Text("SwiftUI")
                    Text("Swift")
                    Text("iOS")
                }.padding(10)
                    .background(Color.blue)
            }
            .frame(maxWidth: .infinity)
            .background(Color.orange)
            .animation(.easeInOut, value: alignmentProp)
            
            HStack {
                Button("Top") {
                    alignmentProp = .top
                }
                
                Button("Center") {
                    alignmentProp = .center
                }
                
                Button("Bottom") {
                    alignmentProp = .bottom
                }
                
                Button("First Text") {
                    alignmentProp = .firstTextBaseline
                }
                
                Button("Last Text") {
                    alignmentProp = .lastTextBaseline
                }
            }
            .padding(20)
            
            // MARK: Priority
            HStack {
                Capsule()
                    .fill(Color.red)
                    .overlay(Text("p:\(Int(redPriority)) Red"))
                    .frame(minWidth: 50)
                    .layoutPriority(redPriority)
                    .animation(.easeInOut, value: redPriority)
                
                Capsule()
                    .fill(Color.blue)
                    .overlay(Text("p:\(Int(bluePriority)) Blue"))
                    .frame(minWidth: 50)
                    .layoutPriority(bluePriority)
                    .animation(.easeInOut, value: bluePriority)
                
                Capsule()
                    .fill(Color.green)
                    .overlay(Text("p:\(Int(greenPriority)) Green"))
                    .frame(minWidth: 50)
                    .layoutPriority(greenPriority)
                    .animation(.easeInOut, value: greenPriority)
            }
            .frame(maxHeight: 200)
            
            HStack {
                Button("Red") {
                    redPriority = redPriority == 1.0 ? 2.0 : 1.0
                }
                
                Button("Blue") {
                    bluePriority = bluePriority == 1.0 ? 2.0 : 1.0
                }
                
                Button("Green") {
                    greenPriority = greenPriority == 1.0 ? 2.0 : 1.0
                }
            }
        }
    }
}

struct HStackDemo_Previews: PreviewProvider {
    static var previews: some View {
        HStackDemo()
    }
}
