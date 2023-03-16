//
//  ListDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-15.
//

import SwiftUI

// UITableView
struct ListDemo: View {
    var body: some View {
        List {
            CustomRowView("Apple", description: "Eat one a day", titleIcon: "🍏", count: 2)
            CustomRowView("Banana", description: "High in potassium", titleIcon: "🍌", count: 3)
            CustomRowView("Mango", description: "Soft and sweet", titleIcon: "🥭")
        }
    }
}

private struct CustomRowView: View {
    var title: String
    var description: String?
    var titleIcon: String
    var count: Int
    
    init(_ title: String, description: String? = nil, titleIcon: String, count: Int = 1) {
        self.title = title
        self.description = description
        self.titleIcon = titleIcon
        self.count = count
    }
    
    var body: some View {
        HStack {
            Text(titleIcon)
                .font(.title)
                .padding(4)
                .background(Color(UIColor.tertiarySystemFill))
                .cornerRadius(10)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                if let description = description {
                    Text(description)
                        .font(.subheadline)
                }
            }
            Spacer()
            Text("\(count)")
                .font(.title)
        }
    }
}

struct ListDemo_Previews: PreviewProvider {
    static var previews: some View {
        ListDemo()
    }
}
