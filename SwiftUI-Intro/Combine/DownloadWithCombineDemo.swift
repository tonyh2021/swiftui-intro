//
//  DownloadWithCombineDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-21.
//

import SwiftUI
import Combine

class DownloadWithCombineViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        // 1. create the publisher
        // 2. subscribe publisher on background thread
        // 3. recieve on main thread
        // 4. tryMap (check the data is good)
        // 5. decode(into PostModel)
        // 6. sink(put the item into the UI)
        // 7. store (cancel subscription if needed)
        URLSession.shared.dataTaskPublisher(for: url)
//            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    print("Completion: finished")
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] result in
                self?.posts = result
            }
            .store(in: &cancellables)
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
        response.statusCode >= 200 && response.statusCode < 300
        else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}

struct DownloadWithCombineDemo: View {
    
    @StateObject private var vm = DownloadWithCombineViewModel()
    
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

struct DownloadWithCombineDemo_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithCombineDemo()
    }
}
