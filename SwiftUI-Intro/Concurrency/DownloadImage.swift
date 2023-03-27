//
//  DownloadImage.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-25.
//

import SwiftUI
import Combine

class DownloadImageLoader {
    
    let url = URL(string: "https://picsum.photos/200")!
    
    private func handleResponse(data: Data?, response: URLResponse?) -> UIImage? {
        guard let data = data,
              let image = UIImage(data: data),
              let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            return nil
        }
        return image
    }
    
    func downloadWithEscaping(completion: @escaping (_ image: UIImage?, _ error: Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response
            , error in
            guard let self = self else { return }
            let image = self.handleResponse(data: data, response: response)
            completion(image, error)
        }
        .resume()
    }
    
    func downloadWithCombine() -> AnyPublisher<UIImage?, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(handleResponse)
            .mapError({ $0 })
            .eraseToAnyPublisher()
    }
    
    @available(iOS 15, *)
    func downloadWithAsync() async throws -> UIImage? {
        do {
            let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
            let image = handleResponse(data: data, response: response)
            return image
        } catch {
            throw error
        }
    }
    
}

class DownloadImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    
    let loader = DownloadImageLoader()
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchImage() {
//        image = UIImage(systemName: "heart.fill")
        
//        loader.downloadWithEscaping { [weak self] image, error in
//            guard let self = self else { return }
//            DispatchQueue.main.async {
//                self.image = image
//            }
//        }
        
        loader.downloadWithCombine()
            .receive(on: DispatchQueue.main)
            .sink { _ in

            } receiveValue: { [weak self] image in
                guard let self = self else { return }
                self.image = image
            }
            .store(in: &cancellables)
        
        
    }
    
    func fetchImageAsync() async {
        if #available(iOS 15, *) {
            let image = try? await loader.downloadWithAsync()
            await MainActor.run {
                self.image = image
            }
        } else {
            fetchImage()
        }
    }
}

struct DownloadImage: View {
    
    @StateObject private var vm = DownloadImageViewModel()
    
    
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
//            vm.fetchImage()
            
            Task {
                await vm.fetchImageAsync()
            }
        }
    }
}

struct DownloadImage_Previews: PreviewProvider {
    static var previews: some View {
        DownloadImage()
    }
}
