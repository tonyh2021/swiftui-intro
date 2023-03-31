//
//  FutureDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-30.
//

import SwiftUI
import Combine

class FutureDemoViewModel: ObservableObject {
    
    @Published var title: String = "First Title"
    
    private let url = URL(string: "https://www.google.com")!
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        download()
    }
    
    func download() {
        fetchFuturePublisher()
        //        fetchCombinePublisher()
            .sink { _ in
                
            } receiveValue: { [weak self] result in
                self?.title = result
            }
            .store(in: &cancellables)
    }
    
    func download2() {
        fetchEscapingClosure { [weak self] result, _ in
            self?.title = result
        }
    }
    
    func fetchCombinePublisher() -> AnyPublisher<String, URLError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .timeout(1, scheduler: DispatchQueue.main)
            .map ({ _ in
                return "New Value"
            })
            .eraseToAnyPublisher()
    }
    
    func fetchEscapingClosure(completion: @escaping (_ value: String, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion("New Value 2", nil)
        }
        .resume()
    }
    
    func fetchFuturePublisher() -> Future<String, Error> {
        Future { promise in
            self.fetchEscapingClosure { value, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(value))
                }
            }
        }
    }
    
    func doSomething(completion: @escaping (_ value: String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            completion("New world!")
        }
    }
    
    func doSomethingInFuture() -> Future<String, Never> {
        Future { promise in
            self.doSomething { value in
                promise(.success(value))
            }
        }
    }
}

struct FutureDemo: View {
    
    @StateObject private var vm = FutureDemoViewModel()
    
    var body: some View {
        Text(vm.title)
    }
}

struct FutureDemo_Previews: PreviewProvider {
    static var previews: some View {
        FutureDemo()
    }
}
