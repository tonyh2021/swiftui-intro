//
//  SwiftUI_IntroApp.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-15.
//

import SwiftUI

@main
struct SwiftUI_IntroApp: App {
    let persistenceController = PersistenceController.shared
    
    let userIsSignedIn: Bool
    
    init() {
        userIsSignedIn = CommandLine.arguments.contains("-UITest_startSignedIn")
        print("User is signed in: \(userIsSignedIn)")
        
//        let userIsSignedIn2 = ProcessInfo.processInfo.environment["-UITest_startSignedIn2"] == "true" ? true : false
//        print("User is signed in: \(userIsSignedIn2)")
    }
    
    var body: some Scene {
        WindowGroup {
            UITestingDemo(currentUserIsSignedIn: userIsSignedIn)
        }
    }
}
