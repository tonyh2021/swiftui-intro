//
//  ArrayDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-19.
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String
    let email: String?
    let point: Int
    let isVerified: Bool
}

class ArrayModificationViewModel: ObservableObject {
    
    @Published var dataArray: [UserModel] = []
    
    @Published var filteredArray: [UserModel] = []
    
    @Published var mapedArray: [String] = []
    
    init() {
        getUser()
        updateFilteredArray()
    }
    
    func updateFilteredArray() {
        // sort
//        filteredArray = dataArray.sorted { user1, user2 in
//            return user1.point > user2.point
//        }
//
//        filteredArray = dataArray.sorted(by: { $0.point > $1.point })
        
        // filter
//        filteredArray = dataArray.filter { user in
//            return user.isVerified
//        }
        
//        filteredArray = dataArray.filter { $0.point > 9 }
        
        // map
//        mapedArray = dataArray.map { user in
//            return user.email ?? "no email"
//        }

//        mapedArray = dataArray.map { $0.name }
        
//        mapedArray = dataArray.compactMap { user in
//            return user.email
//        }
        
        var arrays = [[UserModel]]()
        arrays.append(dataArray)
        arrays.append([
            UserModel(name: "Tony 21", email: "tong21@gmail.com", point: 21, isVerified: true),
            UserModel(name: "Tony 22", email: "tong22@gmail.com", point: 22, isVerified: true),
            
        ])
//        print(arrays)
        filteredArray = arrays.flatMap { $0 }
        mapedArray = arrays.flatMap { $0 }
            .compactMap { $0.email }
    }
    
    func getUser() {
        for index in 0...9 {
            let userModel = UserModel(name: "Tony \(index)", email: (index % 3 == 0 ? "tong\(index)@gmail.com" : nil), point: index + 5, isVerified: (index % 2 == 0))
            self.dataArray.append(userModel)
        }
    }
}

struct ArrayDemo: View {
    
    @StateObject private var vm = ArrayModificationViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
//                ForEach(vm.filteredArray) { user in
//                    VStack(alignment: .leading) {
//                        Text(user.name)
//                            .font(.headline)
//                        HStack {
//                            Text("Point: \(user.point)")
//                            Spacer()
//                            if user.isVerified {
//                                Image(systemName: "flame.fill")
//                            }
//                        }
//                    }
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.blue.cornerRadius(10))
//                    .padding(.horizontal)
//                }
                ForEach(vm.mapedArray, id: \.self) { name in
                    Text(name)
                        .font(.title)
                }
            }
        }
    }
}

struct ArrayDemo_Previews: PreviewProvider {
    static var previews: some View {
        ArrayDemo()
    }
}
