//
//  StructClassActorDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-27.
//

import SwiftUI

/**
 - https://stackoverflow.com/questions/24217586/structure-vs-class-in-swift-language
 - https://medium.com/@vinayakkini/swift-basics-struct-vs-class-31b44ade28ae
 - https://stackoverflow.com/questions/24217586/structure-vs-class-in-swift-language/59219141#59219141
 - https://stackoverflow.com/questions/27441456/swift-stack-and-heap-understanding
 - https://stackoverflow.com/questions/24232799/why-choose-struct-over-class/24232845
 - https://www.backblaze.com/blog/whats-the-diff-programs-processes-and-threads/
 - https://medium.com/doyeona/automatic-reference-counting-in-swift-arc-weak-strong-unowned-925f802c1b99

 Value types:
 - Struct, Enum, String, Int, etc.
 - Store in stack
 - Faster
 - Thread safe!
 - new copy when assigned or pass value.
 
 Reference types:
 - Class, Function, Actor
 - Store in heep
 - Slower, but synchronized
 - NOT thread safe
 - new pointer when assigned or pass reference.
 
 Stack:
 - Store value types.
 - Variables allocated on the stack are stored directlu to the memory, and access is fast.
 - Each thread has its own stack.
 
 Heap:
 - Store reference types
 - Shared accross threads
 
 Struct:
 - Based on Value.
 - Can be muted.
 - Stored in stack.
 
 Class:
 - Based on Reference
 - Stored in heap.
 - Inherit from other classes.
 
 Actor:
 - Same as Class, but thread safe!
 
 Struct: Data Model, Views(SwiftUI)
 Class: ViewModel
 Actor: Shared 'Manager' or 'Data Store'
 */

class ActorDemoViewModel: ObservableObject {
    
    @Published var titles: [String] = []
    
    init() {
        print("ActorDemoViewModel init")
    }
    
    func runTest() {
        titles.append("Test start...")
        actorTest1()
    }
    
    private func structTest2() {
        var str1 = MyStruct(title: "Starting title!")
        titles.append("Str1: \(str1.title)")
        str1.title = "Second Title!"
        titles.append("Str1: \(str1.title)")
        
        var str2 = MutatingStruct(title: "Starting title!")
        titles.append("Str2: \(str2.title)")
        str2.updateTitle("Second Title!")
        titles.append("Str2: \(str2.title)")
    }
    
    private func classTest2() {
        let obj1 = MyClass(title: "Starting title!")
        titles.append("Obj1: \(obj1.title)")
        obj1.title = "Second Title!"
        titles.append("Str1: \(obj1.title)")
        
        let obj2 = MyClass(title: "Starting title!")
        titles.append("Obj2: \(obj2.title)")
        obj2.updateTitle("Second Title!")
        titles.append("Obj2: \(obj2.title)")
    }
    
    private func structTest1() {
        let str1 = MyStruct(title: "Starting title!")
        titles.append("Str1: \(str1.title)")
        
        // Passing value
        var str2 = str1
        titles.append("Str2: \(str2.title)")
        
        str2.title = "Second Title!"
        titles.append("Str2 title changed")
        
        titles.append("Str1: \(str1.title)")
        titles.append("Str2: \(str2.title)")
        
        titles.append("")
    }
    
    private func classTest1() {
        let obj1 = MyClass(title: "Starting title!")
        titles.append("Obj1: \(obj1.title)")
        
        // Passing reference
        let obj2 = obj1
        titles.append("Obj2: \(obj2.title)")
        
        obj2.title = "Second Title!"
        titles.append("Obj2 title changed")
        
        titles.append("Obj1: \(obj1.title)")
        titles.append("Obj2: \(obj2.title)")
        
        titles.append("")
    }
    
    private func actorTest1() {
        Task { @MainActor in
            let act1 = MyActor(title: "Starting title!")
            self.titles.append("Act1: \(await act1.title)")
            
            // Passing reference
            let act2 = act1
            self.titles.append("Act2: \(await act2.title)")
            
            await act2.updateTitle("Second title!")
            self.titles.append("Act2 title changed")
            
            self.titles.append("Act1: \(await act1.title)")
            self.titles.append("Act2: \(await act2.title)")
        }
    }
}

struct StructClassActorDemo: View {
    
    // differences between StateObject and ObservedObject
    @StateObject private var vm = ActorDemoViewModel()
//    @ObservedObject private var vm = ActorDemoViewModel()
    
    let isActive: Bool
    
    init(isActive: Bool) {
        self.isActive = isActive
        print("ActorDemo init")
    }
    
    var body: some View {
        VStack {
            Text("Hello World!")
                .font(.title)
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .background(isActive ? Color.red : Color.blue)
            List {
                ForEach(vm.titles, id: \.self) { title in
                    Text(title)
                        .font(.subheadline)
                }
            }.onAppear {
                vm.runTest()
            }
        }
    }
}

struct ActorHomeView: View {
    
    @State private var isActive: Bool = false
    
    init() {
        print("ActorHomeView init")
    }
    
    var body: some View {
        StructClassActorDemo(isActive: isActive)
            .onTapGesture {
                isActive.toggle()
            }
    }
}

struct MyStruct {
    // we should not use var in most cases.
    var title: String
}

struct MutatingStruct {
    private(set) var title: String
    
    init(title: String) {
        self.title = title
    }
    
    mutating func updateTitle(_ title: String) {
        self.title = title
    }
}

class MyClass {
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
    func updateTitle(_ title: String) {
        self.title = title
    }
}

actor MyActor {
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
    func updateTitle(_ title: String) {
        self.title = title
    }
}

struct StructClassActorDemo_Previews: PreviewProvider {
    static var previews: some View {
        ActorHomeView()
    }
}
