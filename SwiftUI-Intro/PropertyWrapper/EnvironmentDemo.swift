//
//  EnvironmentDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-16.
//

import SwiftUI

struct EnvironmentDemo: View {
    
    /// Similar to @EnvironmentObject
    /// @Environment is to @EnvironmentObject what @State is to @StateObject.
    /// inject some value into the SwiftUI environment using a key(must use .environment(...))
    /// be available to all subviews
    
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    
    @Environment(\.appStyle) var appStyle: AppStyle
    
    var body: some View {
        VStack {
            Text("The color scheme is \(colorScheme == .dark ? "dark" : "light")")
            Text("The style is \(appStyle == .classic ? "classic" : "modern")")
        }
    }
}

// The type we want to use for the custom environment value
enum AppStyle {
    case classic, modern
}

// Our environment key
private struct AppStyleKey: EnvironmentKey {
    static let defaultValue = AppStyle.modern
}

// Register the key on SwiftUI's EnvironmentValues
extension EnvironmentValues {
    var appStyle: AppStyle {
        get { self[AppStyleKey.self] }
        set { self[AppStyleKey.self] = newValue }
    }
}

struct EnvironmentDemo_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentDemo()
            .environment(\.appStyle, .modern)
    }
}
