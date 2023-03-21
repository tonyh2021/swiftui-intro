//
//  CodableDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-21.
//

import SwiftUI

struct CustomerModel: Identifiable, Codable {
    var id: String
    
    let name: String
    let points: Int
    let isPremium: Bool
    
//    init(id: String, name: String, points: Int, isPremium: Bool) {
//        self.id = id
//        self.name = name
//        self.points = points
//        self.isPremium = isPremium
//    }
//
//    enum CodingKeys: CodingKey {
//        case id
//        case name
//        case points
//        case isPremium
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(String.self, forKey: .id)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.points = try container.decode(Int.self, forKey: .points)
//        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(self.id, forKey: .id)
//        try container.encode(self.name, forKey: .name)
//        try container.encode(self.points, forKey: .points)
//        try container.encode(self.isPremium, forKey: .isPremium)
//    }
}

class PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class CodableViewModel: ObservableObject {
    
    @Published var customer: CustomerModel?
    @Published var posts: [PostModel] = []
    
    init() {
//        getData()
        getPosts()
    }
    
    func getData() {
        guard let data = getJSONData() else { return }
        print(data)
//        if let localData = try? JSONSerialization.jsonObject(with: data, options: []),
//           let dict = localData as? [String: Any],
//           let id = dict["id"] as? String,
//           let name = dict["name"] as? String,
//           let points = dict["points"] as? Int,
//           let isPremium = dict["isPremium"] as? Bool {
//            customer = CustomerModel(id: id, name: name, points: points, isPremium: isPremium)
//        }
        
        customer = try? JSONDecoder().decode(CustomerModel.self, from: data)
    }
    
    func getJSONData() -> Data? {
//        let dict: [String: Any] = [
//            "id" : "12345",
//            "name" : "Joe",
//            "points" : 5,
//            "isPremium" : true
//        ]
//        let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [])
        let customer = CustomerModel(id: "12345", name: "Joe", points: 5, isPremium: true)
        let jsonData = try? JSONEncoder().encode(customer)
        return jsonData
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        downloadData(fromURL: url) { data in
            if let data = data {
                guard let newPosts = try? JSONDecoder().decode([PostModel].self, from: data) else { return }
                DispatchQueue.main.async {
                    self.posts = newPosts
                }
            } else {
                print("No data returned...")
            }
        }
        
        
    }
    
    func downloadData(fromURL url: URL, completion: @escaping (_ data: Data?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                  error == nil,
                  let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300
            else {
                print("Failed download data! Error:\(error.debugDescription)")
                completion(nil)
                return
            }
            
//            print("Successfullly download data!")
//            print(data)
//            let jsonString = String(data: data, encoding: .utf8)
//            print(jsonString ?? "")
            
            completion(data)
        }.resume()
    }
}

struct CodableDemo: View {
    
    @StateObject private var vm = CodableViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(Color.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct CodableDemo_Previews: PreviewProvider {
    static var previews: some View {
        CodableDemo()
    }
}
