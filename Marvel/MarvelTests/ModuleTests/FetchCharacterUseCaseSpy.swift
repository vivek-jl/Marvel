//
//  FetchCharacterUseCaseSpy.swift
//  MarvelTests
//
//  Created by Vivek Jayakumar on 6/2/22.
//

import Foundation
import Foundation
import Combine
@testable import Marvel

final class FetchCharacterUseCaseSpy: FetchCharacterUseCaseType {
    
    var isSuccess = true
    var callCount = 0
    
    func fetchCharacterPage() -> AnyPublisher<[Character], APIError> {
        callCount += 1
        if isSuccess == true {
            let character = Character(id: 1, name: "3-D Man",
                                      description: "comic description",
                                      thumbnail: ComicImage(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
                                                       ext: "jpg"),
                                      comics: nil,
                                      series: nil,
                                      stories: nil,
                                      events: nil)
            return Just([character])
                .setFailureType(to: APIError.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: APIError.invalidResponse(errorMessage: "Mock Error"))
                .eraseToAnyPublisher()
        }
    }
    
}
