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
        var endpoint = MarvelCharacterEndpoint()
        endpoint.queryItems = [URLQueryItem(name: "limit", value: "30"),
                               URLQueryItem(name: "offset", value: "\(pageNumber)")]
        
        return apiClient.request(type: CharacterDataWrapper.self, endpoint: endpoint)
            .map { return $0.data?.results }
            .replaceNil(with: [])
            .eraseToAnyPublisher()
    }
}
