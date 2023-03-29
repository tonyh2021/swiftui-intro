//
//  MockDataService.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-29.
//

import Foundation
import Combine

protocol DataServiceProtocol {
    func downloadItemsWithCompletion(completion: @escaping (_ items: [String]) -> Void)
    func downloadItemsWithCombine() -> AnyPublisher<[String], Error>
}

class MockDataService: DataServiceProtocol {
    
    let items: [String]
    
    init(items: [String]?) {
        self.items = items ?? [
            "One", "Two", "Three"
        ]
    }
    
    func downloadItemsWithCompletion(completion: @escaping (_ items: [String]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion(self.items)
        }
    }
    
    func downloadItemsWithCombine() -> AnyPublisher<[String], Error> {
        Just(items)
            .tryMap { publishedItems in
                guard !publishedItems.isEmpty else {
                    throw URLError(.badServerResponse)
                }
                return publishedItems
            }
            .eraseToAnyPublisher()
    }
}
