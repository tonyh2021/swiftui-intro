//
//  GridDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-15.
//

import SwiftUI

// UCollectionView
struct VGridDemo: View {
    
    private var symbols = ["keyboard", "hifispeaker.fill", "printer.fill", "tv.fill", "desktopcomputer", "headphones", "tv.music.note", "mic", "plus.bubble", "video"]
    
    private var colors: [Color] = [.yellow, .purple, .green]
    
//        private var gridItemLayout = Array(repeating: GridItem(.flexible(), spacing: 0), count: 3)
    
//        private var gridItemLayout = [GridItem(.adaptive(minimum: 50))]
    
//        private var gridItemLayout = [GridItem(.fixed(150)), GridItem(.fixed(100))]
    
    private var gridItemLayout = [GridItem(.fixed(150)), GridItem(.adaptive(minimum: 60))]
    
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItemLayout, spacing: 20) {
                ForEach((0...99), id: \.self) {
                    Image(systemName: symbols[$0 % symbols.count])
                        .font(.system(size: 30))
                    //                        .frame(width: 50, height: 50)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50) // make the grid items wider
                        .background(colors[$0 % colors.count])
                        .cornerRadius(10)
                }
            }
        }
//        .frame(width: 300)
        .background(Color.gray)
    }
}

struct HGridDemo: View {
    private var symbols = ["keyboard", "hifispeaker.fill", "printer.fill", "tv.fill", "desktopcomputer", "headphones", "tv.music.note", "mic", "plus.bubble", "video"]
    
    private var colors: [Color] = [.yellow, .purple, .green]
    
    private var gridItemLayout = [GridItem(.fixed(150)), GridItem(.adaptive(minimum: 50))]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: gridItemLayout, spacing: 20) {
                ForEach((0...9999), id: \.self) {
                    Image(systemName: symbols[$0 % symbols.count])
                        .font(.system(size: 30))
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: .infinity)
                        .background(colors[$0 % colors.count])
                        .cornerRadius(10)
                }
            }
        }
    }
}

let sampleCafes: [Cafe] = {
    var cafes = (1...18).map { Cafe(image: "cafe-\($0)") }

    for index in cafes.indices {
        let randomNumber = Int.random(in: (2...12))
        cafes[index].coffeePhotos = (1...randomNumber).map { Photo(name: "coffee-\($0)") }
    }

    return cafes
}()

struct SwitchableGridDemo: View {

    @State var gridLayout: [GridItem] = [GridItem()]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                    
                    ForEach(sampleCafes) { cafe in
                        Image(cafe.image)
                            .resizable()
                            .scaledToFill()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: gridLayout.count == 1 ? 200 : 100)
                            .cornerRadius(10)
                            .shadow(color: Color.primary.opacity(0.3), radius: 1)
                    }
                }
                .padding(.all, 10)
                .animation(.interactiveSpring(), value: gridLayout.count)
            }
            .navigationTitle("Coffee Feed")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.gridLayout = Array(repeating: .init(.flexible()), count: self.gridLayout.count % 4 + 1)
                    } label: {
                        Image(systemName: "square.grid.2x2")
                            .font(.title)
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }
}

struct MultipleGridDemo: View {
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    
    @State var gridLayout: [GridItem] = [GridItem()]
    
//    @State var gridLayout: [GridItem] = [GridItem(.adaptive(minimum: 100)), GridItem(.flexible())]
    
    @State var showSecondaryGrid = false
    @State var secondaryGridLayout: [GridItem] = [GridItem(.adaptive(minimum: 50))]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {

                    ForEach(sampleCafes) { cafe in
                        Image(cafe.image)
                            .resizable()
                            .scaledToFill()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(maxHeight: 150)
                            .cornerRadius(10)
                            .shadow(color: Color.primary.opacity(0.3), radius: 1)
                        
                        if (showSecondaryGrid) {
                            LazyVGrid(columns: secondaryGridLayout) {
                                ForEach(cafe.coffeePhotos) { photo in
                                    Image(photo.name)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .frame(height: 50)
                                        .cornerRadius(10)
                                }
                            }
                            .frame(minHeight: 0, maxHeight: .infinity, alignment: .top)
                            .animation(.easeIn, value: showSecondaryGrid)
                        }
                    }

                }
                .padding(.all, 10)
                .animation(.interactiveSpring(), value: gridLayout.count)
            }
            .navigationTitle("Coffee Feed")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSecondaryGrid.toggle()
                    } label: {
                        Image(systemName: "squares.below.rectangle")
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                    .frame(width: 30)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.gridLayout = Array(repeating: .init(.flexible()), count: self.gridLayout.count % 2 + 1)
                    } label: {
                        Image(systemName: "square.grid.3x2")
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                    .frame(width: 30)
                }
            }
        }
        .onChange(of: verticalSizeClass) { value in
            let count = verticalSizeClass == .compact  ? 1 : 2
            self.gridLayout = Array(repeating: .init(.flexible()), count:count)
        }
    }
}

struct Photo: Identifiable {
    var id = UUID()
    var name: String
}

struct Cafe: Identifiable {
    var id = UUID()
    var image: String
    var coffeePhotos: [Photo] = []
}

struct GridDemo_Previews: PreviewProvider {
    static var previews: some View {
        VGridDemo()
    }
}
