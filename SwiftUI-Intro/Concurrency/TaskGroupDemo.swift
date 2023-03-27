//
//  TaskGroupDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-26.
//

import SwiftUI

class TaskGroupDataManager {
    
    func fetchImagesWithAsyncLet() async throws -> [UIImage] {
        async let fetchImage1 = fetchImage(urlString: "https://picsum.photos/200")
        async let fetchImage2 = fetchImage(urlString: "https://picsum.photos/200")
        async let fetchImage3 = fetchImage(urlString: "https://picsum.photos/200")
        async let fetchImage4 = fetchImage(urlString: "https://picsum.photos/200")
        
        let (image1, image2, image3, image4) = await (
            try fetchImage1,
            try fetchImage2,
            try fetchImage3,
            try fetchImage4
        )
        return [image1, image2, image3, image4]
    }
    
    func fetchImagesWithTaskGroup() async throws -> [UIImage] {
        let urlStrings = [
            "https://picsum.photos/200",
            "https://picsum.photos/200",
            "https://picsum.photos/200",
            "https://picsum.photos/200",
            "https://picsum.photos/200"
        ]
        return try await withThrowingTaskGroup(of: UIImage?.self) { group in
            var images: [UIImage] = []
            images.reserveCapacity(urlStrings.count)
            
            for urlString in urlStrings {
                group.addTask {
                    try? await self.fetchImage(urlString: urlString)
                }
            }
            
//            group.addTask {
//                try await self.fetchImage(urlString: "https://picsum.photos/200")
//            }
//            group.addTask {
//                try await self.fetchImage(urlString: "https://picsum.photos/200")
//            }
//            group.addTask {
//                try await self.fetchImage(urlString: "https://picsum.photos/200")
//            }
//            group.addTask {
//                try await self.fetchImage(urlString: "https://picsum.photos/200")
//            }
            for try await image in group {
                if let image = image {
                    images.append(image)
                }
            }
            return images
        }
    }
    
    private func fetchImage(urlString: String) async throws -> UIImage {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                return image
            } else {
                throw URLError(.badURL)
            }
        } catch {
            throw error
        }
    }
}

class TaskGroupViewModel: ObservableObject {
    
    @Published var images: [UIImage] = []
    private let manager = TaskGroupDataManager()
    
    func fetchImages() async {
        if let images = try? await manager.fetchImagesWithTaskGroup() {
            self.images.append(contentsOf: images)
        }
    }
}

struct TaskGroupDemo: View {
    
    @StateObject private var vm = TaskGroupViewModel()
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(vm.images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }
                }
            }
            .navigationTitle("Async Let 🥲")
            .onAppear {
                test1()
            }
        }
    }
    
    private func test1() {
        Task {
            await vm.fetchImages()
        }
    }
}

struct TaskGroupDemo_Previews: PreviewProvider {
    static var previews: some View {
        TaskGroupDemo()
    }
}
