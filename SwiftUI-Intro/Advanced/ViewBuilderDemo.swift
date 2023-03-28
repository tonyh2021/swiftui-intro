//
//  ViewBuilderDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-28.
//

import SwiftUI

struct HeaderRegular: View {
    
    let title: String
    let description: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            if let description = description {
                Text(description)
                    .font(.callout)
            }
            
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct HeaderGeneric<Content : View>: View {
    
    let title: String
    var content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            content
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct CustomHStack<Content : View>: View {
    
    var content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        HStack {
            content
        }
    }
}

struct LocalViewBuilder: View {
    
    enum ViewType {
        case one, two, three
    }
    
    let type: ViewType
    
    var body: some View {
        VStack {
            headerSection
        }
    }
    
    @ViewBuilder private var headerSection: some View {
        switch type {
        case .one:
            viewOne
        case .two:
            viewTwo
        case .three:
            viewThree
        }
    }
    
    private var viewOne: some View {
        Text("One!")
    }
    
    private var viewTwo: some View {
        VStack {
            Text("Two!")
            Image(systemName: "apple.logo")
        }
    }
    
    private var viewThree: some View {
        Image(systemName: "apple.logo")
    }
}

struct ViewBuilderDemo: View {
    var body: some View {
        VStack(spacing: 16) {
//            HeaderRegular(title: "New title", description: "Hello")
//
//            HeaderRegular(title: "New title", description: nil)
//
//            HeaderGeneric(title: "HeaderGeneric") {
//                Text("content")
//            }
//            HeaderGeneric(title: "HeaderGeneric") {
//                Image(systemName: "heart.fill")
//            }
            
            HeaderGeneric(title: "Header Generic") {
                HStack {
                    Image(systemName: "heart.fill")
                    Text("heart")
                }
            }
            
            CustomHStack {
                Text("Hi")
                Text("Hi")
            }
            
            LocalViewBuilder(type: .one)
            
            Spacer()
        }
    }
}

struct ViewBuilderDemo_Previews: PreviewProvider {
    static var previews: some View {
        ViewBuilderDemo()
    }
}
