//
//  CharacterViewModelTests.swift
//  MarvelTests
//
//  Created by Vivek Jayakumar on 6/2/22.
//

import XCTest
import XCTest
import Combine
@testable import Marvel

class CreditScoreViewModelTests: XCTestCase {
        
    private var sut: CharactersViewModel?
    
    override func setUpWithError() throws {
      
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testFetchCreditScore() {
         let useCase =  FetchCharacterUseCaseSpy()
        sut = CharactersViewModel(fetchCharacterUseCase: useCase)
        let fetchCompleted = XCTestExpectation(description: "CreditScore ViewModel Fetch Completed")
      
        sut?.loadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(useCase.callCount, 1)
            XCTAssertEqual(self.sut?.characters.count, 1)
            fetchCompleted.fulfill()
            self.wait(for: [fetchCompleted], timeout: 1)
        }
    }
}
