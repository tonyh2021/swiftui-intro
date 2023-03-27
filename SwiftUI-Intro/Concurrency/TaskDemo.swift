//
//  TaskDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-26.
//

import SwiftUI

class TaskDemoViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var image2: UIImage? = nil
    
    func featchImage() async {
        try? await Task.sleep(nanoseconds: 5_000_000_000)
        do {
            guard let url = URL(string: "https://picsum.photos/1000") else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            await MainActor.run(body: {
                self.image = UIImage(data: data)
                print("Got image1!")
            })
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func featchImage2() async {
        do {
            guard let url = URL(string: "https://picsum.photos/1000") else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            await MainActor.run(body: {
                self.image2 = UIImage(data: data)
                print("Got image2!")
            })
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct TaskDemo: View {
    
    @StateObject private var vm = TaskDemoViewModel()
    
    @State private var fetchImageTask: Task<(), Never>? = nil
    
    var body: some View {
        
        if #available(iOS 15.0, *) {
            imageView
            .task {
                test5()
            }
        } else {
            // Fallback on earlier versions
            imageView
            .onDisappear {
                fetchImageTask?.cancel()
            }
            .onAppear {
                //            test1()
                //            test2()
                //            test3()
                //            test4()
                test5()
            }
        }
    }
    
    func test1() {
        Task {
            await vm.featchImage()
            // suspend
            await vm.featchImage2()
        }
    }
    
    func test2() {
        Task {
            print(Thread.current)
            print(Task.currentPriority)
            await vm.featchImage()
        }
        Task {
            print(Thread.current)
            print(Task.currentPriority)
            await vm.featchImage2()
        }
    }
    
    func test3() {
//      The order is indeterminate.
        Task(priority: .high) {
//      let other task go first
//          try? await Task.sleep(nanoseconds: 2_000_000_000)
            await Task.yield()
            print("1 high: \(Thread.current), \(Task.currentPriority)")
        }
        
        Task(priority: .userInitiated) {
            print("2 userInitiated: \(Thread.current), \(Task.currentPriority)")
        }
        
        Task(priority: .medium) {
            print("3 medium: \(Thread.current), \(Task.currentPriority)")
        }
        
        Task(priority: .low) {
            print("4 low: \(Thread.current), \(Task.currentPriority)")
        }
        
        Task(priority: .utility) {
            print("5 utility: \(Thread.current), \(Task.currentPriority)")
        }
        
        Task(priority: .background) {
            print("6 background: \(Thread.current), \(Task.currentPriority)")
        }
        Task(priority: .high) {
            print("7 high: \(Thread.current), \(Task.currentPriority)")
        }
    }
    
    func test4() {
        Task(priority: .low) {
            print("low: \(Thread.current), \(Task.currentPriority)")
            
            Task.detached {
                print("detached: \(Thread.current), \(Task.currentPriority)")
            }
        }
    }
    
    func test5() {
        fetchImageTask = Task {
            await vm.featchImage()
        }
    }
}

extension TaskDemo {
    
    private var imageView: some View {
        VStack(spacing: 40) {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            if let image = vm.image2 {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
    }
    
}

struct TaskDemoHomeView: View {
    var body: some View {
        
        NavigationView {
            ZStack {
                NavigationLink("Click me! 🤓") {
                    TaskDemo()
                }
            }
        }
    }
}

struct TaskDemo_Previews: PreviewProvider {
    static var previews: some View {
        TaskDemo()
    }
}
