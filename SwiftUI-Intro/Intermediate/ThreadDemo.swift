//
//  ThreadDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-20.
//

import SwiftUI

class ThreadDemoViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    func fetchData() {
        
        DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()
            
            print("$$ 1: \(Thread.isMainThread)")
            print("$$ 1: \(Thread.current)")
            
            DispatchQueue.main.async {
                self.dataArray = newData
                
                print("$$ 2: \(Thread.isMainThread)")
                print("$$ 2: \(Thread.current)")
            }
        }
    }
    
    private func downloadData() -> [String] {
        var data: [String] = []
        for x in 0..<100 {
            data.append("\(x)")
            print(data)
        }
        return data
    }
}

struct ThreadDemo: View {
    
    @StateObject private var vm = ThreadDemoViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                Text("Load data")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
            }
            ForEach(vm.dataArray, id: \.self) { item in
                Text(item)
                    .font(.headline)
                    .foregroundColor(.red)
            }
        }
    }
}

struct ThreadDemo_Previews: PreviewProvider {
    static var previews: some View {
        ThreadDemo()
    }
}
