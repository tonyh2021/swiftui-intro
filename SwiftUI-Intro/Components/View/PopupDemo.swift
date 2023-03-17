//
//  PopupDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-16.
//

import SwiftUI

struct PopupDemo: View {
    
    @State private var showSheet: Bool = false
    
    var body: some View {
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
