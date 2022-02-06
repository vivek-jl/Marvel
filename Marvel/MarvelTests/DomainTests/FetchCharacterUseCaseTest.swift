//
//  FetchCharacterUseCaseTest.swift
//  MarvelTests
//
//  Created by Vivek Jayakumar on 6/2/22.
//

import Foundation
import XCTest
import Combine
@testable import Marvel

class FetchCharacterUseCaseTest: XCTestCase {
    private var cancellables: Set<AnyCancellable>!

    private var sut: FetchCharacterUseCase?
    override func setUpWithError() throws {
        sut = FetchCharacterUseCase(apiClient: APIClientSpy())
        cancellables = []
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testSuccesfulCall() {
        
        guard let parsedJSON = JSONParser().parseJSONfile("SampleMarvelJSON", model: CharacterDataWrapper.self) else {
            XCTFail("Unable to parse JSON")
            return
        }
        
        let mockAPIClient  = sut?.apiClient as! APIClientSpy
        mockAPIClient.modelItem = parsedJSON

            
        let fetchCompleted = XCTestExpectation(description: "Use Case Fetch Completed")
        defer {
            self.wait(for: [fetchCompleted], timeout: 5)
        }
        var object: [Character]? = nil
        var error: Error?
        
        sut?.fetchCharacterPage()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(encounteredError):
                    error = encounteredError
                }
                XCTAssertNil(error)
                XCTAssertEqual(object?[0].name, "3-D Man")
                XCTAssertEqual(object?[0].comics?.items?.count, 12)

                fetchCompleted.fulfill()
            }, receiveValue: { value in
                object = value
            })
            .store(in: &cancellables)
    }
    
}

