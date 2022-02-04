//
//  MarvelEndpoint.swift
//  Marvel
//
//  Created by Vivek Jayakumar on 3/2/22.
//

import Foundation

struct MarvelEndpoint: EndpointType {
    var method: HTTPMethod = .get
    var subPath: String = "/v1/public/comics"
    var headers: HTTPHeaders? = nil
    var queryItems: [URLQueryItem] {
        return commonQueryItems
    }
    var timeout: Double = 20
}
