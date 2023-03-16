//
//  NavigationDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-15.
//

import SwiftUI

struct NavigationDemo: View {
    var body: some View {
        demo4
    }
}

extension NavigationDemo {
    
    private var demo1: some View {
        NavigationView {
            Text("Hello")
                .navigationBarTitle(Text("SwiftUI"), displayMode: .automatic)
        }
    }
    
    private var demo2: some View {
        NavigationView {
            Text("Hello")
                .navigationBarTitle(Text("SwiftUI"), displayMode: .large)
                .navigationBarItems(
                    trailing:
                        Button(
                            action: {
                                print("Going to Setting")
                            },
                            label: { Text("Setting") }
                        )
                )
        }
    }
    
    private var demo3: some View {
        NavigationView {
            VStack {
                Text("Hello")
                NavigationLink(
                    destination: SecondPage(),
                    label: {
                    Text("Navigate")
                })
            }
            .navigationTitle("SwiftUI")
        }
    }
    
    private var demo4: some View {
        NavigationView {
            ZStack {
                Color.green.ignoresSafeArea()
                VStack {
                    Text("Hello")
                    NavigationLink(
                        destination: SecondPage()
                            .navigationBarBackButtonHidden(true)
                        ,
                        label: {
                        Text("Navigate")
                    })
                }
            }
            .navigationTitle("SwiftUI")
        }
    }
}

struct SecondPage: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Text("Destination")
            .onTapGesture {
                // go back
                self.presentationMode.wrappedValue.dismiss()
            }
            .navigationTitle("Second")
    }
}

struct CustomNavBarDemo: View {
    var body: some View {
        CustomNavView {
            ZStack {
                Color.green.ignoresSafeArea()
                VStack {
                    Text("Hello")
                    
                    CustomNavLink(
                        destination: SecondPage()
                            .customNavigationTitle("Second Title")
                            .customNavigationSubitle("Second Subtitle")
                            .customNavigationBarBackButtonHidden(false)
                        ,
                        label: {
                            Text("Navigate")
                                .foregroundColor(.white)
                    })
                    
                    NavigationLink(
                        destination: SecondPage()
                            .navigationBarBackButtonHidden(true)
                        ,
                        label: {
                            Text("Navigate")
                                .foregroundColor(.white)
                    })
                }
            }
            .customNavBarItems(title: "New Title", backButtonHidden: true)
        }
    }
}


struct NavigationDemo_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBarDemo()
    }
}
