//
//  AsyncAwaitDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-25.
//

import SwiftUI

class AsyncAwaitViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    func addTitle1() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // definitely a main thread
            let title1 = "Title1: \(Thread.current)"
            self.dataArray.append(title1)
        }
    }
    
    func addTitle2() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            // just a normal thread
            let title = "Title2: \(Thread.current)"
            DispatchQueue.main.async {
                self.dataArray.append(title)
                
                // main thread
                let title3 = "Title3: \(Thread.current)"
                self.dataArray.append(title3)
            }
        }
    }
    
    func addAuthor() async {
        let author1 = "Author1: \(Thread.current)"
        // Warning for Update UI in background threads
        self.dataArray.append(author1)
        
        // Author1 and Author2 may be in different Threads by adding this line.
        try? await Task.sleep(nanoseconds: 2_000_000_000)

        let author2 = "Author2: \(Thread.current)"
        
        await MainActor.run(body: {
            self.dataArray.append(author2)
            
//             main thread
            let author3 = "Author3: \(Thread.current)"
            self.dataArray.append(author3)
        })
    }
    
    func addSomething() async {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        
        let something1 = "Something1: \(Thread.current)"
        await MainActor.run(body: {
            self.dataArray.append(something1)
//
//            // main thread
            let something2 = "Something2: \(Thread.current)"
            self.dataArray.append(something2)
        })
    }
}

struct AsyncAwaitDemo: View {
    
    @StateObject private var vm = AsyncAwaitViewModel()

    var body: some View {
        List {
            ForEach(vm.dataArray, id: \.self) { data in
                Text(data)
            }
        }
        .onAppear {
//            vm.addTitle1()
//            vm.addTitle2()
            Task {
                await vm.addAuthor()
                await vm.addSomething()
                
                // main thread
                let final = "Final: \(Thread.current)"
                vm.dataArray.append(final)
            }
        }
    }
}

struct AsyncAwaitDemo_Previews: PreviewProvider {
    static var previews: some View {
        AsyncAwaitDemo()
    }
}
