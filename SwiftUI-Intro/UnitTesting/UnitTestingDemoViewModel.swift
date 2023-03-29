//
//  UnitTestingDemoViewModel.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-29.
//

import SwiftUI
import Combine

class UnitTestingDemoViewModel: ObservableObject {
    
    @Published var isPremium: Bool
    @Published var dataArray: [String] = []
    @Published var selectedItem: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    let dateService: DataServiceProtocol
    
    init(isPremium: Bool, dateService: DataServiceProtocol = MockDataService(items: nil)) {
        self.isPremium = isPremium
        self.dateService = dateService
    }
    
    func addItem(item: String) {
        guard !item.isEmpty else { return }
        self.dataArray.append(item)
    }
    
    func selectItem(item: String) {
        if let x = dataArray.first(where: { $0 == item }) {
            selectedItem = x
        } else {
            selectedItem = nil
        }
    }
    
    func saveItem(item: String) throws {
        guard !item.isEmpty else { throw DataError.noData }
        
        if let x = dataArray.first(where: { $0 == item }) {
            print("Save item here!! \(x)")
        } else {
            throw DataError.itemNotFound
        }
        
    }
    
    enum DataError: LocalizedError {
        case noData
        case itemNotFound
    }
    
    func downloadWithCompletion() {
        dateService.downloadItemsWithCompletion { [weak self] items in
            self?.dataArray = items
        }
    }
    
    func downloadWithCombine() {
        dateService.downloadItemsWithCombine()
            .sink { _ in
                
            } receiveValue: { [weak self] items in
                self?.dataArray = items
            }
            .store(in: &cancellables)
    }
}
