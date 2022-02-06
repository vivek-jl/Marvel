//
//  APIClientSpy.swift
//  MarvelTests
//
//  Created by Vivek Jayakumar on 6/2/22.
//

import Foundation
import Combine
import Foundation

@testable import Marvel

final class APIClientSpy: APIClientType {
    
    init(configuration: URLSessionConfiguration = .ephemeral) { }

    var isSuccess = true

    var modelItem: Codable?

    func request<T: Decodable>(type: T.Type, endpoint: EndpointType)
        -> AnyPublisher<T, APIError>
    {
        if let data = modelItem {
            isSuccess = true
            return Just(data as! T)
                .setFailureType(to: APIError.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: APIError.invalidResponse(errorMessage: "Mock Error"))
                .eraseToAnyPublisher()
        }
    }
}
