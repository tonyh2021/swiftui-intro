//
//  AppStorageDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-16.
//

import SwiftUI

struct AppStorageDemo: View {
    
    /// Based on UserDefaults, key/value storage
    /// Simple user preferences
    /// Simple state for next restart
    
    @AppStorage("lastTap") var lastTap: Double?
    
    var dateString: String {
        if let timestamp = lastTap {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .medium
            return formatter.string(from: Date(timeIntervalSince1970: timestamp))
        } else {
            return "Never"
        }
    }
    
    var body: some View {
        VStack {
            Text("Button was last clicked on")
            Text(dateString)
            Button("Click to track the tap time") {
                lastTap = Date().timeIntervalSince1970
            }
        }
    }
}

struct AppStorageDemo_Previews: PreviewProvider {
    static var previews: some View {
        AppStorageDemo()
    }
}
