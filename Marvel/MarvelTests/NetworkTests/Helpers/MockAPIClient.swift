//
//  MockAPIClient.swift
//  MarvelTests
//
//  Created by Vivek Jayakumar on 03/02/22.

import Combine
import Foundation
import Resolver
@testable import Marvel

final class MockAPIClient: APIClientType {
    
    init(configuration: URLSessionConfiguration = Resolver.resolve()) { }

    var isSuccess = true

    var modelItem: Codable?

    func request<T: Decodable>(type: T.Type, endpoint: EndpointType)
        -> AnyPublisher<T, APIError>
    {
        if let data = modelItem {
            return Just(data as! T)
                .setFailureType(to: APIError.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: APIError.invalidResponse(errorMessage: "Mock Error"))
                .eraseToAnyPublisher()
        }
    }
}
