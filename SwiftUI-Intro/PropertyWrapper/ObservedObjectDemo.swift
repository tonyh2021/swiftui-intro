//
//  ObservedObjectDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-16.
//

import SwiftUI

struct ObservedObjectDemo: View {
    var body: some View {
        DataOwnerView()
    }
}

struct DataOwnerView: View {
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
            
            DataUserView(vm: vm)
        }
    }
}

struct DataUserView: View {
    
    /// 1. Current view does not hold the property(otherwise should use @StateObject)
    /// 2. iOS 13 does not support @StateObject
    /// 3. Should follow ObservableObject
    
    @ObservedObject var vm: ViewModel
    
    var body: some View {
        VStack {
            Text("ObservedObject1 Value: \(vm.currentValue)")
            
            Button {
                print("tapped...")
                vm.currentValue += 1
            } label: {
                Text("Tap me...")
            }
            DataUserView2(vm: vm)
        }
    }
}

struct DataUserView2: View {
    
    @ObservedObject var vm: ViewModel
    
    var body: some View {
        VStack {
            Text("ObservedObject2 Value: \(vm.currentValue)")
            
            Button {
                print("tapped...")
                vm.currentValue += 1
            } label: {
                Text("Tap me...")
            }
        }
    }
}

struct ObservedObjectDemo_Previews: PreviewProvider {
    static var previews: some View {
        ObservedObjectDemo()
    }
}
