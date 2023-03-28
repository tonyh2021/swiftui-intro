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
    
    var body: some Scene {
        WindowGroup {
            ActorDemo()
        }
    }
}
