//
//  GlobalActorDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-27.
//

import SwiftUI

@globalActor
struct GlobalActorStruct {
    
    static var shared = GlobalActorManager()
    
}

actor GlobalActorManager {
    
    func fetchDataFromDatabase() -> [String] {
        
        return ["One", "Two", "Three", "Four", "Five"]
    }
}

class GlobalActorDemoViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    private var manager = GlobalActorManager()
    
    private var globalActorManager = GlobalActorStruct.shared
    
    @GlobalActorStruct
    func fetchData() {
        Task {
            // heavy complex ...
            
            let data = await manager.fetchDataFromDatabase()
            await MainActor.run(body: {
                self.dataArray = data
            })
        }
    }
}

struct GlobalActorDemo: View {
    
    @StateObject private var vm = GlobalActorDemoViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(vm.dataArray, id: \.self) {
                    Text($0)
                        .font(.headline)
                }
            }
        }
        .onAppear {
            Task {
                await vm.fetchData()
            }
        }
    }
    
}

struct GlobalActorDemo_Previews: PreviewProvider {
    static var previews: some View {
        GlobalActorDemo()
    }
}
