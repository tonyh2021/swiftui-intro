//
//  AsyncLetDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-26.
//

import SwiftUI

struct AsyncLetDemo: View {
    
    private let url = URL(string: "https://picsum.photos/200")!
    
    @State private var images: [UIImage] = []
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }
                }
            }
            .navigationTitle("Async Let 🥲")
            .onAppear {
                test3()
            }
        }
    }
    
    private func test3() {
        Task {
            
            let (image1, image2, image3, image4) = await (
                try fetchImage(),
                try fetchImage(),
                try fetchImage(),
                try fetchImage()
            )
            
            self.images.append(contentsOf: [image1, image2, image3, image4])
        }
    }
    
    private func test2() {
        Task {
            let image1 = try await fetchImage()
            self.images.append(image1)
        }
        Task {
            let image2 = try await fetchImage()
            self.images.append(image2)
        }
        Task {
            let image3 = try await fetchImage()
            self.images.append(image3)
        }
        Task {
            let image4 = try await fetchImage()
            self.images.append(image4)
        }
    }
    
    private func test1() {
        Task {
            async let image1 = fetchImage()
            try await self.images.append(image1)
            
            async let image2 = fetchImage()
            try await self.images.append(image2)

            let image3 = try await fetchImage()
            self.images.append(image3)

            let image4 = try await fetchImage()
            self.images.append(image4)
        }
    }
    
    private func fetchImage() async throws -> UIImage {
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

struct AsyncLetDemo_Previews: PreviewProvider {
    static var previews: some View {
        AsyncLetDemo()
    }
}
