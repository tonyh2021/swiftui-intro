//
//  CoreDataDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-19.
//

import SwiftUI
import CoreData

struct CoreDataDemo: View {
    
    @Environment(\.managedObjectContext) private var viewContext;
    
    @FetchRequest(
        entity: FruitEntity.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \FruitEntity.name, ascending: true)
        ])
    private var fruits: FetchedResults<FruitEntity>
    
    @State private var textFieldText: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Add fruit here...", text: $textFieldText)
                    .font(.headline)
                    .padding(.leading)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button {
                    addItem()
                } label: {
                    Text("Button")
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                List {
                    ForEach(fruits) { fruit in
                        Text(fruit.name ?? "")
                            .onTapGesture {
                                updateItem(fruit: fruit)
                            }
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Fruits")
        }
    }

    private func addItem() {
        withAnimation {
            let newFruit = FruitEntity(context: viewContext)
            newFruit.name = textFieldText

            saveItems()
            
            textFieldText = ""
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { fruits[$0] }.forEach(viewContext.delete)
            
            saveItems()
        }
    }
    
    private func updateItem(fruit: FruitEntity) {
        withAnimation {
            fruit.name = (fruit.name ?? "") + "!"
            saveItems()
        }
    }
    
    private func saveItems() {
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

struct CoreDataDemo_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataDemo().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
