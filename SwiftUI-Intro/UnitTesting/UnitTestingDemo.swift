//
//  UnitTestingDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-29.
//

import SwiftUI

struct UnitTestingDemo: View {
    
    @StateObject private var vm: UnitTestingDemoViewModel
    
    init(isPremium: Bool) {
        self._vm = StateObject(wrappedValue: UnitTestingDemoViewModel(isPremium: isPremium))
    }

    var body: some View {
        Text("Hello, World!")
    }
}

struct UnitTestingDemo_Previews: PreviewProvider {
    static var previews: some View {
        UnitTestingDemo(isPremium: true)
    }
}
