//
//  FetchCharacterUseCase.swift
//  Marvel
//
//  Created by Vivek Jayakumar on 6/2/22.
//

import Foundation
import Combine
import Resolver

protocol FetchCharacterUseCaseType {
     func fetchCharacterPage() -> AnyPublisher<[Character], APIError>
}

class FetchCharacterUseCase: FetchCharacterUseCaseType {
    
    let apiClient: APIClientType
    
    private var pageNumber = 0
    private var limit = 30
    
    
    init(apiClient: APIClientType = Resolver.resolve()) {
        self.apiClient = apiClient
    }
    
    func fetchCharacterPage() -> AnyPublisher<[Character], APIError> {
        
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
              let offset = pageNumber * limit
              endpoint.queryItems = [URLQueryItem(name: "limit", value: "\(limit)"),
                                     URLQueryItem(name: "offset", value: "\(offset)")]
              
              return apiClient.request(type: CharacterDataWrapper.self, endpoint: endpoint)
                  .handleEvents(receiveOutput: { [weak self] value in
                      if value.data?.count ?? 0 > 0 { self?.pageNumber += 1 }
                    })
                  .map { return $0.data?.results }
                  .replaceNil(with: [])
                  .eraseToAnyPublisher()
          }
       
    }
}
