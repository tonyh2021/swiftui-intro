//
//  AsyncPublisherDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-28.
//

import SwiftUI
import Combine

class AsyncPublisherDemoActor {
    
    @Published var data: [String] = []
    
    func addData() async {
        data.append("Apple")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        data.append("Banana")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        data.append("Orange")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        data.append("Watermelon")
    }
}

class AsyncPublisherDemoViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    private let manager = AsyncPublisherDemoActor()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        Task {
            if #available(iOS 15.0, *) {
                for await value in manager.$data.values {
                    await MainActor.run(body: {
                        self.dataArray = value
                    })
                }
            } else {
                // Fallback on earlier versions
            }
            
        }
        
//        manager.$data
//            .receive(on: DispatchQueue.main, options: nil)
//            .sink { dataArray in
//                self.dataArray = dataArray
//            }
//            .store(in: &cancellables)
    }
    
    func start() async {
        await manager.addData()
    }
}

struct AsyncPublisherDemo: View {
    
    @StateObject private var vm = AsyncPublisherDemoViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.dataArray, id: \.self) { data in
                    Text(data)
                        .font(.headline)
                }
            }
        }
        .onAppear {
            Task {
                await vm.start()
            }
        }
    }
}

struct AsyncPublisherDemo_Previews: PreviewProvider {
    static var previews: some View {
        AsyncPublisherDemo()
    }
}
