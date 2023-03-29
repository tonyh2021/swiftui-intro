//
//  MockDataService_Tests.swift
//  SwiftUI-Intro-Tests
//
//  Created by Tony on 2023-03-29.
//

import XCTest
@testable import SwiftUI_Intro;
import Combine

final class MockDataService_Tests: XCTestCase {
    
    private var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cancellables.removeAll()
    }

    func test_MockDataService_init_doesSetValuesCorrectly() throws {
        // Given
        let items: [String]? = nil
        let items2: [String]? = []
        let items3: [String]? = [UUID().uuidString, UUID().uuidString]
        
        // When
        let ds = MockDataService(items: items)
        let ds2 = MockDataService(items: items2)
        let ds3 = MockDataService(items: items3)
        
        // Then
        XCTAssertFalse(ds.items.isEmpty)
        XCTAssertTrue(ds2.items.isEmpty)
        XCTAssertEqual(ds3.items.count, items3?.count)
    }
    
    func test_MockDataService_downloadItemsWithCompletion_doesReturnValues() throws {
        // Given
        let ds = MockDataService(items: nil)
        
        // When
        var items: [String] = []
        let expectation = XCTestExpectation()
        
        ds.downloadItemsWithCompletion { result in
            items = result
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(items.count, ds.items.count)
    }
    
    func test_MockDataService_downloadItemsWithCombine_doesReturnValues() throws {
        // Given
        let ds = MockDataService(items: nil)
        
        // When
        var items: [String] = []
        let expectation = XCTestExpectation()
        
        ds.downloadItemsWithCombine()
            .sink { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                    break
                case .failure(let error):
                    XCTFail()
                    break
                }
            } receiveValue: { result in
                items = result
            }
            .store(in: &cancellables)
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(items.count, ds.items.count)
    }
    
    func test_MockDataService_downloadItemsWithCombine_doesFail() throws {
        // Given
        let ds = MockDataService(items: [])
        
        // When
        var items: [String] = []
        let expectation = XCTestExpectation(description: "Does throw an error")
        let expectation2 = XCTestExpectation(description: "Does throw an URLError.badServerResponse")
        
        ds.downloadItemsWithCombine()
            .sink { completion in
                switch completion {
                case .finished:
                    XCTFail()
                    break
                case .failure(let error):
                    expectation.fulfill()
                    
//                    let urlError = error as? URLError
//                    XCTAssertEqual(urlError, URLError(.badServerResponse))
                    
                    if error as? URLError == URLError(.badServerResponse) {
                        expectation2.fulfill()
                    }
                    break
                }
            } receiveValue: { result in
                items = result
            }
            .store(in: &cancellables)
        
        // Then
        wait(for: [expectation, expectation2], timeout: 5)
        XCTAssertEqual(items.count, ds.items.count)
    }
    
    func test_MockDataService_downloadItemsWithCombine_doesReturnValues2() throws {
        // Given
        let items = [UUID().uuidString, UUID().uuidString, UUID().uuidString, UUID().uuidString, UUID().uuidString]
        let ds = MockDataService(items: items)
        
//        UnitTestingDemoViewModel does not have MockDataService dependency.
        let vm = UnitTestingDemoViewModel(isPremium: Bool.random(), dateService: ds)
        
        // When
        let expectation = XCTestExpectation(description: "Sould return items after a second.")
        
        vm.$dataArray
            .dropFirst()
            .sink { result in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        vm.downloadWithCombine()
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(vm.dataArray.count, items.count)
    }
}
