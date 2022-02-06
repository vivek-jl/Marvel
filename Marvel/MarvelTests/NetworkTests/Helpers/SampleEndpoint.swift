//
//  SampleEndpoint.swift
//  MarvelTests
//
//  Created by Vivek Jayakumar on 3/2/22.
//

import Foundation
@testable import Marvel

struct SampleEndpoint: EndpointType {
    var queryItems: [URLQueryItem]? = nil
    
    var allQueryItems: [URLQueryItem] {
        return commonQueryItems
    }
    
    var method: HTTPMethod = .get
    
    var headers: HTTPHeaders? = nil
    
    var payload: HTTPParameters? = nil
    
    var subPath: String = "/test"
    
    var timeout: Double = 10
    
    var request: URLRequest {
        return URLRequest(url: URL(string: "https://www.google.com")!)
    }
    
    
}
