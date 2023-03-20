//
//  CoreDataMVVMDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-19.
//

import SwiftUI
import CoreData

// View - UI
// Model - data point
// ViewModel - manages the data for a view

class CoreDataViewModel: ObservableObject {
    
    @Published var savedEntities: [FruitEntity] = []
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading core data. \(error)")
            } else {
                print("Successfully loaded core data!")
            }
        }
        fetchEntities()
    }
    
    func fetchEntities() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func addEntity(name: String) {
        let newEntity = FruitEntity(context: container.viewContext)
        newEntity.name = name
        
        saveData()
    }
    
    func updateEntity(entity: FruitEntity) {
        entity.name = (entity.name ?? "") + "!"
        
        saveData()
    }
    
    func deleteEntity(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        
        saveData()
    }
    
    private func saveData() {
        do {
            try container.viewContext.save()
            fetchEntities()
        } catch let error {
            print("Error saving \(error)")
        }
    }
}

struct CoreDataMVVMDemo: View {
    
    @StateObject private var vm = CoreDataViewModel()
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
                    guard !textFieldText.isEmpty else { return }
                    vm.addEntity(name: textFieldText)
                    textFieldText = ""
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
                    ForEach(vm.savedEntities) { fruit in
                        Text(fruit.name ?? "No Name")
                            .onTapGesture {
                                vm.updateEntity(entity: fruit)
                            }
                    }
                    .onDelete(perform: vm.deleteEntity)
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Fruits")
        }
    }
}

struct CoreDataMVVMDemo_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataMVVMDemo()
    }
}
