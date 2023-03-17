//
//  StateDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-16.
//

import SwiftUI

/// https://www.hackingwithswift.com/quick-start/swiftui/all-swiftui-property-wrappers-explained-and-compared
///
/// @AppStorage reads and writes values from UserDefaults. This owns its data. https://www.hackingwithswift.com/quick-start/swiftui/what-is-the-appstorage-property-wrapper
///
/// @Binding refers to value type data owned by a different view. Changing the binding locally changes the remote data too. This does not own its data. https://www.hackingwithswift.com/quick-start/swiftui/what-is-the-binding-property-wrapper
///
/// @Environment lets us read data from the system, such as color scheme, accessibility options, and trait collections, but you can add your own keys here if you want. This does not own its data. https://www.hackingwithswift.com/quick-start/swiftui/what-is-the-environment-property-wrapper
///
/// @EnvironmentObject reads a shared object that we placed into the environment. This does not own its data. https://www.hackingwithswift.com/quick-start/swiftui/what-is-the-environmentobject-property-wrapper
///
/// @FetchRequest starts a Core Data fetch request for a particular entity. This owns its data. https://www.hackingwithswift.com/quick-start/swiftui/what-is-the-fetchrequest-property-wrapper
///
/// @FocusedBinding is designed to watch for values in the key window, such as a text field that is currently selected. This does not own its data.
///
/// @FocusedValue is a simpler version of @FocusedBinding that doesn’t unwrap the bound value for you. This does not own its data.
///
/// @GestureState stores values associated with a gesture that is currently in progress, such as how far you have swiped, except it will be reset to its default value when the gesture stops. This owns its data. https://www.hackingwithswift.com/quick-start/swiftui/what-is-the-gesturestate-property-wrapper
///
/// @Namespace creates an animation namespace to allow matched geometry effects, which can be shared by other views. This owns its data.
///
/// @NSApplicationDelegateAdaptor is used to create and register a class as the app delegate for a macOS app. This owns its data.
///
/// @ObservedObject refers to an instance of an external class that conforms to the ObservableObject protocol. This does not own its data. https://www.hackingwithswift.com/quick-start/swiftui/what-is-the-observedobject-property-wrapper
///
/// @Published is attached to properties inside an ObservableObject, and tells SwiftUI that it should refresh any views that use this property when it is changed. This owns its data. https://www.hackingwithswift.com/quick-start/swiftui/what-is-the-published-property-wrapper
///
/// @ScaledMetric reads the user’s Dynamic Type setting and scales numbers up or down based on an original value you provide. This owns its data. https://www.hackingwithswift.com/quick-start/swiftui/what-is-the-scaledmetric-property-wrapper
///
/// @SceneStorage lets us save and restore small amounts of data for state restoration. This owns its data. https://www.hackingwithswift.com/quick-start/swiftui/what-is-the-scenestorage-property-wrapper
///
/// @State lets us manipulate small amounts of value type data locally to a view. This owns its data. https://www.hackingwithswift.com/quick-start/swiftui/what-is-the-state-property-wrapper
///
/// @StateObject is used to store new instances of reference type data that conforms to the ObservableObject protocol. This owns its data. https://www.hackingwithswift.com/quick-start/swiftui/what-is-the-stateobject-property-wrapper
///
/// @UIApplicationDelegateAdaptor is used to create and register a class as the app delegate for an iOS app. This owns its data. https://www.hackingwithswift.com/quick-start/swiftui/what-is-the-uiapplicationdelegateadaptor-property-wrapper
///

struct StateDemo: View {
    
    /// 1. inside of current View/ View holds State
    /// 2. respond to changes
    /// 3. private as a best-practice
    
    @State private var backgroundColor: Color = Color.green
    @State private var count: Int = 0
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Count: \(count)")
                HStack(spacing: 20) {
                    Button("Button 1") {
                        backgroundColor = .red
                        count += 1
                    }
                    Button("Button 2") {
                        backgroundColor = .green
                        count -= 1
                    }
                }
            }
        }
        .font(.title)
        .foregroundColor(.white)
    }
}

struct StateDemo_Previews: PreviewProvider {
    static var previews: some View {
        StateDemo()
    }
}
