//
//  EndpointType.swift
//  CreditScore
//
//  Created by Vivek Jayakumar on 26/1/22.
//

import Foundation

typealias HTTPParameters = [String: Any]

typealias HTTPHeaders = [String: String]

protocol EndpointType {
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var queryItems: [URLQueryItem] { get }
    var subPath: String { get }
    var timeout: Double { get }
    var request: URLRequest { get }
}


