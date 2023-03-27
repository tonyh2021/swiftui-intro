//
//  ContinuationDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-27.
//

import SwiftUI

/// convert completion handlers into async functions

class ContinuationDemoDataManager {
    
    func fetchData(url: URL) async throws -> Data {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            throw error
        }
    }
    
    func fetchData2(url: URL) async throws -> Data {
        return try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: url) { data, response, error in
//                resume exactly once
                if let data = data {
                    continuation.resume(returning: data)
                } else if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(throwing: URLError(.badURL))
                }
            }
            .resume()
        }
    }
    
    func fetchDataFromDatabase(completion: @escaping (_ image: UIImage) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            completion(UIImage(systemName: "heart.fill")!)
        }
    }
    
    func fetchDataFromDatabase() async -> UIImage {
        return await withCheckedContinuation { continuation in
            fetchDataFromDatabase { image in
                continuation.resume(returning: image)
            }
        }
    }
}

class ContinuationDemoViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    private let manager = ContinuationDemoDataManager()
    
    func fetchImage() async {
        guard let url = URL(string: "https://picsum.photos/200") else {
            return
        }
        do {
            let data = try await manager.fetchData2(url: url)
            if let image = UIImage(data: data) {
                await MainActor.run(body: {
                    self.image = image
                })
            }
        } catch {
            print(error)
        }
    }
    
    func fetchHeartImage() {
        manager.fetchDataFromDatabase { [weak self] image in
            self?.image = image
        }
    }
    
    func fetchHeartImage2() async {
        self.image = await manager.fetchDataFromDatabase()
    }
}

struct ContinuationDemo: View {
    
    @StateObject private var vm = ContinuationDemoViewModel()

    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .onAppear {
//            vm.fetchHeartImage()
            Task {
                await vm.fetchHeartImage2()
            }
        }
    }
}

struct ContinuationDemo_Previews: PreviewProvider {
    static var previews: some View {
        ContinuationDemo()
    }
}
