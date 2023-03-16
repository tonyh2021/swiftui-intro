//
//  OthersDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-15.
//

import SwiftUI

struct OthersDemo: View {
    @State var isShowing = true //state
    
    @State var value: Double = 0 // State
    @State var value2: Double = 0 // State
    @State var value3: Double = 0 // State
    
    var body: some View {
        VStack {
            GroupBox {
                // UISwitch
                Toggle(isOn: $isShowing) {
                    Text("Hello, SwiftUI!")
                }.onChange(of: isShowing) { value in
                    // action...
                    // https://stackoverflow.com/questions/56996272/how-can-i-trigger-an-action-when-a-swiftui-toggle-is-toggled
                    print(value)
                }.padding()
            }
            
            GroupBox {
                // UISlider
                Slider(value: $value, in: 0...10)
                
                Slider(value: $value2,
                           in: 0...10,
                           step: 2) { didChange in
                        print("Did change: \(didChange)")
                    }.padding()
                
                Slider(value: $value3, in: 0...10) {
                        Text("Slider")
                    } minimumValueLabel: {
                        Text("0").font(.title2).fontWeight(.thin)
                    } maximumValueLabel: {
                        Text("10").font(.title2).fontWeight(.thin)
                    }.padding()
            }
            
            GroupBox {
                // UIProgressView
                ProgressView("Loading")
                ProgressView("Loading", value: value, total: 10)
                    .progressViewStyle(LinearProgressViewStyle())
                    .padding()
                    .foregroundColor(.orange)
                    .accentColor(.yellow) // tint from iOS 16
            }
        }
    }
}

struct OthersDemo_Previews: PreviewProvider {
    static var previews: some View {
        OthersDemo()
    }
}
