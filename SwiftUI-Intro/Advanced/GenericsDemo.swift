//
//  GenericsDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-28.
//

import SwiftUI

struct StringModel {
    
    let info: String?
    
    func removeInfo() -> StringModel {
        StringModel(info: nil)
    }
}

struct GenericModel<T> {
    let info: T?
    func removeInfo() -> GenericModel {
        GenericModel(info: nil)
    }
}

class GenericsDemoViewModel: ObservableObject {
    
    @Published var stringModel = StringModel(info: "Hello SwiftUI!")
    @Published var stringGenericModel = GenericModel(info: "Hello SwiftUI!")
    @Published var boolGenericModel = GenericModel(info: true)
    
    func removeData() {
        stringModel = stringModel.removeInfo()
        stringGenericModel = stringGenericModel.removeInfo()
        boolGenericModel = boolGenericModel.removeInfo()
    }
    
    
    @Published var dataArray: [String] = []
    
    init() {
        dataArray = ["one" , "two", "three"]
    }
    
    func removeDataFromDataArray() {
        dataArray.removeAll()
    }
}

// T -> any Type of View
struct GenericsView<T: View>: View {
    
    let title: String
    let content: T
    
    var body: some View {
        VStack {
            Text(title)
            content
        }
    }
}

struct GenericsDemo: View {
    
    @StateObject private var vm = GenericsDemoViewModel()
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(vm.dataArray, id: \.self) { item in
                Text(item)
                    .onTapGesture {
                        vm.removeDataFromDataArray()
                    }
            }
            Text(vm.stringModel.info ?? "No data")
            Text(vm.stringGenericModel.info ?? "No data")
            Text(vm.boolGenericModel.info?.description ?? "No data")
            
            GenericsView(
                title: "GenericsView",
                content:
                    Text("Content View"))
        }
        .onTapGesture {
            vm.removeData()
        }
    }
}

struct GenericsDemo_Previews: PreviewProvider {
    static var previews: some View {
        GenericsDemo()
    }
}
