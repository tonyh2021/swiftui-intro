//
//  PopupDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-16.
//

import SwiftUI

struct PopupDemo: View {
    
    @State private var selectModel: RandomModel = RandomModel(title: "STARTING TITLE")
    
    @State private var selectModel2: RandomModel? = nil
    
    @State private var showSheet: Bool = false
    @State private var showSheet2: Bool = false
    
    var body: some View {
        demo4
    }
}

struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}

extension PopupDemo {
    
    /// multiple sheet
    /// 1. use a binding
    /// 2. use multiple sheets
    /// 3. use $item
    
    //use a binding
    private var demo2: some View {
        VStack(spacing: 20) {
            Button("Button 1") {
                selectModel = RandomModel(title: "ONE")
                showSheet.toggle()
            }
            Button("Button 2") {
                selectModel = RandomModel(title: "TWO")
                showSheet.toggle()
            }
        }
        .sheet(isPresented: $showSheet, content: {
            NextScreen(selectedModel: $selectModel)
        })
    }
    
    //use multiple sheets
    private var demo3: some View {
        VStack(spacing: 20) {
            Button("Button 1") {
                showSheet.toggle()
            }
            .sheet(isPresented: $showSheet, content: {
                ThirdScreen(selectedModel: RandomModel(title: "ONE"))
            })
            Button("Button 2") {
                showSheet2.toggle()
            }
            .sheet(isPresented: $showSheet2, content: {
                ThirdScreen(selectedModel: RandomModel(title: "TWO"))
            })
        }
    }
    
    //use $item
    private var demo4: some View {
        ScrollView {
            VStack(spacing: 20) {
                Button("Button 1") {
                    selectModel2 = RandomModel(title: "ONE")
                }
                Button("Button 2") {
                    selectModel2 = RandomModel(title: "TWO")
                }
                ForEach(0..<50, id: \.self) { index in
                    Button("Button \(index)") {
                        selectModel2 = RandomModel(title: "\(index)")
                    }
                }
            }
            .sheet(item: $selectModel2) { model in
                ThirdScreen(selectedModel: model)
            }
        }
    }
    
    private var demo1: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            Button {
                print("tapped...")
                showSheet.toggle()
            } label: {
                Text("Tap me...")
                    .foregroundColor(.green)
                    .font(.headline)
                    .padding(20)
                    .background(Color.white.cornerRadius(10))
            }
            /// Method 1 - sheet
//            .sheet(isPresented: $showSheet, content: {
//                SecondScreen()
//            })
//            .fullScreenCover(isPresented: $showSheet, content: {
//                // Do not add conditional logic!!!
//                SecondScreen()
//            })
            
            /// Method 2 - Transition
//            ZStack {
//                if showSheet {
//                    SecondScreen(showSheet: $showSheet)
//                        .padding(.top, 100)
//                        .transition(.move(edge: .bottom))
//                        .animation(.spring())
//                }
//            }
//            .zIndex(2.0)
            
            /// Method 3 - Animation offset
            SecondScreen(showSheet: $showSheet)
                .padding(.top, 100)
                .offset(y: showSheet ? 0 : UIScreen.main.bounds.height)
                .animation(.spring())
        }
    }
}


struct NextScreen: View {
    
    @Binding var selectedModel: RandomModel
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

struct ThirdScreen: View {
    
    let selectedModel: RandomModel
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

struct SecondScreen: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var showSheet: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.red.ignoresSafeArea()
            Button {
                print("tapped...")
//                presentationMode.wrappedValue.dismiss()
                showSheet.toggle()
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding(20)
            }
        }
    }
}

struct PopupDemo_Previews: PreviewProvider {
    static var previews: some View {
        PopupDemo()
    }
}
