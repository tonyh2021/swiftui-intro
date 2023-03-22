//
//  SubscriberDemo.swift
//  SwiftUI-Intro
//
//  Created by Tony on 2023-03-21.
//

import SwiftUI
import Combine

class SubscriberViewModel: ObservableObject {
    
    @Published var count: Int = 0
    private var cancellables = Set<AnyCancellable>()
    
    @Published var textFieldText: String = ""
    @Published var textIsValid: Bool = false
    @Published var showButton: Bool = false
    
    init() {
        setupTimer()
        addTextFieldSubscriber()
        addButtonSubscriber()
    }
    
    func addButtonSubscriber() {
        $textIsValid
            .combineLatest($count)
            .sink { [weak self] isValid, count in
                guard let self = self else { return }
                if isValid && count >= 10 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
    }
    
    func addTextFieldSubscriber() {
        $textFieldText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { (text) -> Bool in
                return text.count > 3
            }
            //.assign(to: \.textIsValid, on: self)
            .sink { [weak self] value in
                guard let self = self else { return }
                self.textIsValid = value
            }
            .store(in: &cancellables)
    }
    
    func setupTimer() {
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.count += 1
                
//                if self.count >= 10 {
//                    for item in self.cancellables {
//                        item.cancel()
//                    }
//                }
            }
            .store(in: &cancellables)
    }
}

struct SubscriberDemo: View {
    
    @StateObject private var vm = SubscriberViewModel()
    
    var body: some View {
        VStack {
            Text("\(vm.count)")
                .font(.largeTitle)
            
            Text(vm.textIsValid.description)
            
            TextField("Type something here...", text: $vm.textFieldText)
                .padding(.leading)
                .frame(height: 55)
                .font(.headline)
                .background(Color.secondary)
                .cornerRadius(10)
                .overlay(
                    ZStack {
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                            .opacity(
                                vm.textFieldText.count < 1 ? 0 :
                                vm.textIsValid ? 0 : 1)
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .opacity(vm.textIsValid ? 1 : 0)
                    }
                        .font(.title)
                        .padding(.trailing)
                    ,
                    alignment: .trailing
                )
            
            Button {
                print("tapped...")
                
            } label: {
                Text("Submite".uppercased())
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .opacity(
                        vm.showButton ? 1.0 : 0.5
                    )
            }
            .disabled(!vm.showButton)
        }
        .padding()
    }
}

struct SubscriberDemo_Previews: PreviewProvider {
    static var previews: some View {
        SubscriberDemo()
    }
}
