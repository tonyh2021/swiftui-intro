//
//  ActorDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-27.
//

import SwiftUI

actor ActorDataManager {
    static let instance = ActorDataManager()
    
    private init() {
        
    }
    
    nonisolated
    let constantData = "Constant Data"
    
    var data:[String] = []
    
    func fetchData() -> String? {
        self.data.append(UUID().uuidString)
        print(Thread.current)
        return self.data.randomElement()
    }
    
    nonisolated
    func fetchDataImmediately() -> String {
        return "New data"
    }
}

class DataManager {
    static let instance = DataManager()
    
    private init() {
        
    }
    
    private let queue = DispatchQueue(label: "com.tony.swiftui.dataManager")
    
    var data:[String] = []
    
    func fetchData(complemtion: @escaping (_ title: String?) -> Void) {
        queue.async {
            self.data.append(UUID().uuidString)
            print(Thread.current)
            complemtion(self.data.randomElement())
        }
    }
}

struct ActorDemoHomeView: View {
    
    private let manager = DataManager.instance
    
    private let actorManager = ActorDataManager.instance
    
    @State private var text: String = ""
    private let timer = Timer.publish(every: 0.1, tolerance: nil, on: .main, in: .common, options: nil).autoconnect()
    
    var body: some View {
        ZStack {
            Color.pink.opacity(0.8).ignoresSafeArea()
            Text(text)
                .font(.headline)
        }
        .onReceive(timer) { _ in
//            updateData()
            updateDataWithActor()
        }
    }
    
    private func updateDataWithActor() {
        
//        self.text = actorManager.constantData
        self.text = actorManager.fetchDataImmediately()
        
//        Task {
//            if let data = await actorManager.fetchData() {
//                await MainActor.run(body: {
//                    self.text = data
//                })
//            }
//        }
    }
    
    private func updateData() {
        DispatchQueue.global(qos: .background).async {
            manager.fetchData(complemtion: { title in
                if let data = title {
                    DispatchQueue.main.async {
                        self.text = data
                    }
                }
            })
        }
    }
}

struct ActorDemoBrowseView: View {
    private let manager = DataManager.instance
    
    private let actorManager = ActorDataManager.instance
    
    @State private var text: String = ""
    private let timer = Timer.publish(every: 0.01, tolerance: nil, on: .main, in: .common, options: nil).autoconnect()
    
    var body: some View {
        ZStack {
            Color.yellow.opacity(0.8).ignoresSafeArea()
            Text(text)
                .font(.headline)
        }
        .onReceive(timer) { _ in
//            updateDataWithActor()
        }
    }
    
    private func updateDataWithActor() {
        Task {
            if let data = await actorManager.fetchData() {
                await MainActor.run(body: {
                    self.text = data
                })
            }
        }
    }
    
    private func updateData() {
        DispatchQueue.global(qos: .default).async {
            manager.fetchData(complemtion: { title in
                if let data = title {
                    DispatchQueue.main.async {
                        self.text = data
                    }
                }
            })
        }
    }
}

struct ActorDemo: View {
    var body: some View {
        TabView {
            ActorDemoHomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            ActorDemoBrowseView()
                .tabItem {
                    Label("Browse", systemImage: "magnifyingglass")
                }
        }
    }
}

struct ActorDemo_Previews: PreviewProvider {
    static var previews: some View {
        ActorDemo()
    }
}
