//
//  SceneStorageDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-16.
//

import SwiftUI

struct SceneStorageDemo: View {
    /// Key/value storage
    /// Simple state for current scene
    /// not sensitive or mission critical
    
    @SceneStorage("lastTap") var lastTap: Double?
    
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

struct SceneStorageDemo_Previews: PreviewProvider {
    static var previews: some View {
        SceneStorageDemo()
    }
}
