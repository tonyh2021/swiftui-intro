//
//  StateObjectDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-16.
//

import SwiftUI

struct StateObjectDemo: View {
    
    /// similar to @State
    /// usually used as ViewModel instance
    /// should follow ObservableObject
    /// @Published
    
    @StateObject private var vm = ViewModel()
    
    var body: some View {
        VStack {
            Text("Value: \(vm.currentValue)")
            Button {
                print("tapped...")
                vm.currentValue += 1
            } label: {
                Text("Tap me...")
            }
        }
    }
}

class ViewModel: ObservableObject {
    
    /// 1. Used inside an ObservableObject
    /// 2. Tell SwiftUI should refresh Views that use this property when it is changed
    @Published var currentValue = 1
}

struct StateObjectDemo_Previews: PreviewProvider {
    static var previews: some View {
        StateObjectDemo()
    }
}
