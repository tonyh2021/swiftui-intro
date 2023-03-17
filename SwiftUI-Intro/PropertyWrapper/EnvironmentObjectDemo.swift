//
//  EnvironmentObjectDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-16.
//

import SwiftUI

struct EnvironmentObjectDemo: View {
    var body: some View {
        ParentView()
    }
}

struct ParentView: View {
    @StateObject private var vm = ViewModel()
    
    var body: some View {
        VStack {
            Text("OwnerView Value: \(vm.currentValue)")
            
            Button {
                print("tapped...")
                vm.currentValue += 1
            } label: {
                Text("Tap me...")
            }
            
            ChildView()
                .environmentObject(vm)
        }
    }
}

struct ChildView: View {
    
    /// Similar to ObservedObject but
    /// use ObservedObject when one to one
    /// Share the state in more than one views(subviews even grandchildviews)
    /// Holding by the original view
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        VStack {
            Text("ChildView Value: \(vm.currentValue)")
            
            Button {
                print("tapped...")
                vm.currentValue += 1
            } label: {
                Text("Tap me...")
            }
            
            ChildView2()
        }
    }
}

struct ChildView2: View {
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        VStack {
            Text("ChildView2 Value: \(vm.currentValue)")
            
            Button {
                print("tapped...")
                vm.currentValue += 1
            } label: {
                Text("Tap me...")
            }
        }
    }
}

struct EnvironmentObjectDemo_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentObjectDemo()
    }
}
