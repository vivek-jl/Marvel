//
//  FetchCharacterUseCase.swift
//  Marvel
//
//  Created by Vivek Jayakumar on 6/2/22.
//

import Foundation
import Combine

protocol FetchCharacterUseCaseType {
    mutating func fetchCharacterPage() -> AnyPublisher<[Character], APIError>
}

struct FetchCharacterUseCase: FetchCharacterUseCaseType {
    
    let apiClient: APIClientType
    
    var pageNumber = 0
    
    mutating func fetchCharacterPage() -> AnyPublisher<[Character], APIError> {
        
        let uiTesting = ProcessInfo.processInfo.arguments.contains("UITesting")
        if uiTesting == true {
            let character = Character(id: 1, name: "3-D Man",
                                      description: "comic description",
                                      thumbnail: ComicImage(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", ext: "jpg"),
                                      comics: nil,
                                      series: nil,
                                      stories: nil,
                                      events: nil)
            return Just([character])
                .setFailureType(to: APIError.self)
                .eraseToAnyPublisher()
           
          } else {
              
              var endpoint = MarvelCharacterEndpoint()
              endpoint.queryItems = [URLQueryItem(name: "limit", value: "30"),
                                     URLQueryItem(name: "offset", value: "\(pageNumber)")]
              
              return apiClient.request(type: CharacterDataWrapper.self, endpoint: endpoint)
                  .map { return $0.data?.results }
                  .replaceNil(with: [])
                  .eraseToAnyPublisher()
          }
       
    }
}
