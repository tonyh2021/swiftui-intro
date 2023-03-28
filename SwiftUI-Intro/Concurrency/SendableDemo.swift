//
//  SendableDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-28.
//

import SwiftUI

actor SendableDemoManager {
    
    func updateData(userInfo: String) {
        
    }
    
}

struct UserInfo: Sendable {
    let name: String
}

/// @unchecked Sendable is dangerous!!!
final class ClassUserInfo: @unchecked Sendable {
    let name: String
    
    private var title: String? = nil
    
    let queue = DispatchQueue(label: "com.tony.SendableDemo")
    
    init(name: String) {
        self.name = name
    }
    
    func updateTitle(_ title: String?) {
        queue.async {
            self.title = title
        }
    }
}

class SendableDemoViewModel: ObservableObject {
    
    let manager = SendableDemoManager()
    
    func updateCurrentUserInfo() async {
        
        let info = "USER INFO"
        await manager.updateData(userInfo: info)
    }
}

struct SendableDemo: View {
    
    @StateObject private var vm = SendableDemoViewModel()
    
    var body: some View {
        Text("Hello, World!")
            .onAppear {
                Task {
                    
                }
            }
    }
}

struct SendableDemo_Previews: PreviewProvider {
    static var previews: some View {
        SendableDemo()
    }
}
