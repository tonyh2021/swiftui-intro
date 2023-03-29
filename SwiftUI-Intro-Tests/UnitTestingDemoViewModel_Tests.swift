//
//  UnitTestingDemoViewModel_Tests.swift
//  SwiftUI-Intro-Tests
//
//  Created by Tony on 2023-03-29.
//

import XCTest
@testable import SwiftUI_Intro;
import Combine

// Name Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
// test_[Struct or Class]_[variable or function]_[expected result]
// Test Structure: Give, When, Then

final class UnitTestingDemoViewModel_Tests: XCTestCase {
    
    private var vm: UnitTestingDemoViewModel?
    private var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        vm = UnitTestingDemoViewModel(isPremium: Bool.random())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        vm = nil
        cancellables.removeAll()
    }

    func test_UnitTestingDemoViewModel_isPremium_shouldBeTrue() throws {
        // Given
        let userIsPremium: Bool = true
        
        // When
        let vm = UnitTestingDemoViewModel(isPremium: userIsPremium)
        
        // Then
        XCTAssertTrue(vm.isPremium)
    }
    
    func test_UnitTestingDemoViewModel_isPremium_shouldBeFalse() throws {
        // Given
        let userIsPremium: Bool = false
        
        // When
        let vm = UnitTestingDemoViewModel(isPremium: userIsPremium)
        
        // Then
        XCTAssertFalse(vm.isPremium)
    }
    
    func test_UnitTestingDemoViewModel_isPremium_shouldBeInjectedValue() throws {
        // Given
        let userIsPremium: Bool = Bool.random()
        
        // When
        let vm = UnitTestingDemoViewModel(isPremium: userIsPremium)
        
        // Then
        XCTAssertEqual(vm.isPremium, userIsPremium)
    }
    
    func test_UnitTestingDemoViewModel_isPremium_shouldBeInjectedValue_stress() throws {
        for _ in 0..<10 {
            // Given
            let userIsPremium: Bool = Bool.random()
            
            // When
            let vm = UnitTestingDemoViewModel(isPremium: userIsPremium)
            
            // Then
            XCTAssertEqual(vm.isPremium, userIsPremium)
        }
    }
    
    func test_UnitTestingDemoViewModel_dataArray_shouldBeEmpty() throws {
        for _ in 0..<10 {
            // Given
            guard let vm = vm else {
                XCTFail()
                return
            }
            
            // When
            
            // Then
            XCTAssertTrue(vm.dataArray.isEmpty)
            XCTAssertEqual(vm.dataArray.count, 0)
        }
    }
    
    func test_UnitTestingDemoViewModel_dataArray_shouldAddItems() throws {
        // Given
        guard let vm = vm else {
            XCTFail()
            return
        }
        
        // When
        let loopCount = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        
        // Then
        XCTAssertFalse(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, loopCount)
    }
    
    func test_UnitTestingDemoViewModel_dataArray_shouldNotAddBlankString() throws {
        // Given
        guard let vm = vm else {
            XCTFail()
            return
        }
        
        // When
        vm.addItem(item: "")
        
        // Then
        XCTAssertTrue(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 0)
    }
    
    func test_UnitTestingDemoViewModel_selectedItem_shouldStartAsNil() throws {
        // Given
        
        
        // When
        guard let vm = vm else {
            XCTFail()
            return
        }
        
        // Then
        XCTAssertTrue(vm.selectedItem == nil)
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UnitTestingDemoViewModel_selectedItem_shouldBeNilWhenSelectingInvalidItem() throws {
        // Given
        guard let vm = vm else {
            XCTFail()
            return
        }
        
        // When
        vm.selectItem(item: UUID().uuidString)
        
        // Then
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UnitTestingDemoViewModel_selectedItem_shouldBeSelected() throws {
        // Given
        guard let vm = vm else {
            XCTFail()
            return
        }
        
        // When
        let newItem = UUID().uuidString
        vm.addItem(item: newItem)
        vm.selectItem(item: newItem)
        
        // Then
        XCTAssertNotNil(vm.selectedItem)
    }
    
    func test_UnitTestingDemoViewModel_selectedItem_shouldBeSelected_stress() throws {
        // Given
        guard let vm = vm else {
            XCTFail()
            return
        }
        
        // When
        let loopCount = Int.random(in: 1..<100)
        var itemsArray: [String] = []
        
        for _ in 0..<loopCount {
            let item = UUID().uuidString
            itemsArray.append(item)
            vm.addItem(item: item)
        }
        
        let randomItem = itemsArray.randomElement() ?? ""
        vm.selectItem(item: randomItem)
        
        // Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, randomItem)
    }

    func test_UnitTestingDemoViewModel_saveItem_shouldThrowError_noData() throws {
        // Given
        guard let vm = vm else {
            XCTFail()
            return
        }
        // When
        let loopCount = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            let item = UUID().uuidString
            vm.addItem(item: item)
        }
        
        // Then
        do {
            try vm.saveItem(item: "")
        } catch let error {
            let error = error as? UnitTestingDemoViewModel.DataError
            XCTAssertEqual(error, UnitTestingDemoViewModel.DataError.noData)
        }
        XCTAssertThrowsError(try vm.saveItem(item: ""))
    }
    
    func test_UnitTestingDemoViewModel_saveItem_shouldSaveItem() throws {
        // Given
        guard let vm = vm else {
            XCTFail()
            return
        }
        // When
        let loopCount = Int.random(in: 1..<100)
        var itemsArray: [String] = []
        
        for _ in 0..<loopCount {
            let item = UUID().uuidString
            itemsArray.append(item)
            vm.addItem(item: item)
        }
        
        let randomItem = itemsArray.randomElement() ?? ""
        
        // Then
        XCTAssertNoThrow(try vm.saveItem(item: randomItem))
        do {
            try vm.saveItem(item: randomItem)
        } catch {
            XCTFail()
        }
    }
    
    func test_UnitTestingDemoViewModel_downloadWithCompletion_shouldReturnItems() {
        // Given
        guard let vm = vm else {
            XCTFail()
            return
        }
        
        // When
        let expectation = XCTestExpectation(description: "Should return items after 3 seconds.")
        
        vm.$dataArray
            .dropFirst()
            .sink { items in
                expectation.fulfill()
            }
            .store(in: &cancellables)

        
        vm.downloadWithCompletion()
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
    func test_UnitTestingDemoViewModel_downloadWithCombine_shouldReturnItems() {
        // Given
        guard let vm = vm else {
            XCTFail()
            return
        }
        
        // When
        let expectation = XCTestExpectation(description: "Should return items after 3 seconds.")
        
        vm.$dataArray
            .dropFirst()
            .sink { items in
                expectation.fulfill()
            }
            .store(in: &cancellables)

        vm.downloadWithCombine()
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
}
