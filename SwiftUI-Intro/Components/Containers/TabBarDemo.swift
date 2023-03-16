//
//  TabBarDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-15.
//

import SwiftUI

struct TabBarDemo: View {
    
    @State private var selection = 0
    @State private var tabSelection: TabBarItem = .home
    
    var body: some View {
        navTabBar
    }
}

struct TabBarDemo_Previews: PreviewProvider {
    
    static var previews: some View {
        TabBarDemo()
    }
}

extension TabBarDemo {
    private var navTabBar: some View {
        NavigationView {
            customTabView
        }
    }
    
    private var customTabView: some View {
        CustomTabBarContainerView(selection: $tabSelection) {
            Color.red.tabBarItem(tab: .home, selection: $tabSelection)
            Color.blue.tabBarItem(tab: .favorites, selection: $tabSelection)
            profileView.tabBarItem(tab: .profile, selection: $tabSelection)
        }
    }
    
    private var profileView: some View {
        ZStack {
            Color.green
            NavigationLink(
                destination: SecondPage(),
                label: {
                    Text("3333")
                        .accentColor(Color.red)
                })
        }
    }
    
    private var defaultTabView: some View {
        TabView(selection: $selection) {
            Text("1").tabItem {
                Image(systemName: "1.lane")
                Text("Page 1")
            }
            .onTapGesture {
                self.selection = 3
            }
            .tag(0)
            
            Text("2").tabItem {
                Image(systemName: "2.lane")
                Text("Page 2")
            }.tag(1)
            
            NavigationLink(
                destination: SecondPage(),
                label: {
                    Text("3")
                        .accentColor(Color.green)
                }).tabItem {
                    Image(systemName: "3.lane")
                    Text("Page 3")
                }.tag(2)
            
            Text("4").tabItem {
                Image(systemName: "4.lane")
                Text("Page 4")
            }.tag(3)
        }
        .accentColor(Color.orange)
    }
}
