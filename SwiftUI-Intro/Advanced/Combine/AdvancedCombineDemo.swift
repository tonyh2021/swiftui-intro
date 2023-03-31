//
//  AdvancedCombineDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-30.
//

import SwiftUI
import Combine

class AdvancedCombineDataService {
    
    @Published var dataPublisher: [String] = []
    @Published var dataPublisher2: String = ""
    
    let currentValuePublisher = CurrentValueSubject<String, Never>("")
    
    let passthroughPublisher = PassthroughSubject<Int, Error>()
    let boolPublisher = PassthroughSubject<Bool, Error>()
    let intPublisher = PassthroughSubject<Int, Error>()
    
    init() {
//        publishMockData()
//        publishMockData2()
//        publishMockData3()
        publishMockData4()
    }
    
    private func publishMockData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.dataPublisher = ["One", "Two", "Three"]
        }
    }
    
    private func publishMockData2() {
        let data = ["One", "Two", "Three"]
        for x in data.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(x)) {
                self.dataPublisher2 = data[x]
            }
        }
        
    }
    
    private func publishMockData3() {
        let data = ["One", "Two", "Three"]
        for x in data.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(x)) {
                self.currentValuePublisher.send(data[x])
            }
        }
        
    }
    
    private func publishMockData4() {
        let data: [Int] = Array(0...10)
        for x in data.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(x)) {
                self.passthroughPublisher.send(data[x])
                
                if x % 3 == 0 {
                    self.boolPublisher.send(true)
                    self.intPublisher.send(999)
                } else {
                    self.boolPublisher.send(false)
                }
                
                if x == data.indices.last {
                    self.passthroughPublisher.send(completion: .finished)
                }
            }
        }
    }
}

class AdvancedCombineViewModel: ObservableObject {
    @Published var data: [String] = []
    @Published var dataBools: [Bool] = []
    @Published var error: String = ""
    let dataService = AdvancedCombineDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        dataService.$dataPublisher
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    break
                }
            } receiveValue: { [weak self] result in
                self?.data = result
            }
            .store(in: &cancellables)
        
        dataService.$dataPublisher2
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    break
                }
            } receiveValue: { [weak self] result in
                self?.data.append(result)
            }
            .store(in: &cancellables)
        
        dataService.currentValuePublisher
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    break
                }
            } receiveValue: { [weak self] result in
                self?.data.append(result)
            }
            .store(in: &cancellables)
        
        let sharedPublisher = dataService.passthroughPublisher
//            .dropFirst(3)
            .share()
            .multicast {
                PassthroughSubject<Int, Error>()
            }
        
        sharedPublisher
        //   Squence Operations
        //            .first()
        //            .first(where: { $0 > 4 })
        //            .tryFirst(where: { result in
        //                if result == 3 {
        //                    throw URLError(.badServerResponse)
        //                }
        //                return result > 5
        //            })
        //            .last(where: { result in
        //                return result < 5
        //            })
        //            .dropFirst(2)
        //            .drop(while: { result in
        //                return result != 3
        //            })
        //            .prefix(while: { result in
        //                return result < 5
        //            })
        //            .output(at: 0)
        //            .output(in: 1..<4)
        
        //  Mathematic Operations
        //            .max(by: { res1, res2 in
        //                return res1 < res2
        //            })
        //            .min()
        
        //  Filter / Reducing Operations
        //            .tryMap({ result in
        //                if result == 5 {
        //                    throw URLError(.badServerResponse)
        //                }
        //                return String(result)
        //            })
        //            .compactMap({ result in
        //                if result == 5 {
        //                    return nil
        //                }
        //                return String(result)
        //            })
        //            .filter({ result in
        //                return result > 3 && result < 7
        //            })
        //            .removeDuplicates()
        //            .replaceNil(with: 5)
        //            .scan(0, { extistingValue, newValue in
        //                return extistingValue + newValue
        //            })
        //            .reduce(0, { extistingValue, newValue in
        //                return extistingValue + newValue
        //            })
        //            .collect()
        //            .collect(3)
        //            .allSatisfy({ result in
        //                result > 0
        //            })
        
        //  Timeing Operations
        //            .debounce(for: 0.75, scheduler: DispatchQueue.main)
        //            .delay(for: 2, scheduler: DispatchQueue.main)
        //            .measureInterval(using: DispatchQueue.main)
        //            .map({ "\($0)"})
        //            .throttle(for: 2, scheduler: DispatchQueue.main, latest: true)
        //            .retry(3)
        //            .timeout(0.75, scheduler: DispatchQueue.main)
        
        //  Multiple Publishers / Subscribers
        //            .combineLatest(dataService.boolPublisher)
        //            .compactMap({ (int, bool) in
        //                return bool ? "\(int)" : nil
        //            })
        //            .removeDuplicates()
        //            .merge(with: dataService.intPublisher)
        //            .zip(dataService.intPublisher)
        //            .map({ (int1, int2) in
        //                return int1 + int2
        //            })
        //            .zip(dataService.boolPublisher, dataService.intPublisher)
        //            .map({ (int1, bool, int2) in
        //                return "\(int1)_\(bool)_\(int2)"
        //            })
        //            .tryMap({ result in
        //                if result == 5 {
        //                    throw URLError(.badServerResponse)
        //                }
        //                return result
        //            })
        //            .catch({ error in
        //                return self.dataService.intPublisher
        //            })
        
            .map({ String($0) })
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = "Error: \(error.localizedDescription)"
                    print(self.error)
                    break
                }
            } receiveValue: { [weak self] result in
                self?.data.append(result)
                //                self?.data.append(contentsOf: result)
            }
            .store(in: &cancellables)
        
        sharedPublisher
            .map ({ $0 > 5 ? true : false })
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = "Error: \(error.localizedDescription)"
                    print(self.error)
                    break
                }
            } receiveValue: { [weak self] result in
                self?.dataBools.append(result)
            }
            .store(in: &cancellables)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            sharedPublisher
                .connect()
                .store(in: &self.cancellables)
        }
    }
}

struct AdvancedCombineDemo: View {
    
    @StateObject private var vm = AdvancedCombineViewModel()
    
    var body: some View {
        ScrollView {
            HStack {
                VStack {
                    ForEach(vm.data, id: \.self) { item in
                        Text(item)
                            .font(.largeTitle)
                            .fontWeight(.black)
                    }
                    Spacer()
                    if !vm.error.isEmpty  {
                        Text(vm.error)
                    }
                }
                VStack {
                    ForEach(vm.dataBools, id: \.self) { item in
                        Text(item.description)
                            .font(.largeTitle)
                            .fontWeight(.black)
                    }
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct AdvancedCombineDemo_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedCombineDemo()
    }
}
