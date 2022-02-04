//
//  Endpoint+Extension.swift
//  Marvel
//
//  Created by Vivek Jayakumar on 4/2/22.
//

import Foundation
import CryptoKit

extension EndpointType {
    var request: URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = BaseURL.domain
        components.path = subPath
        components.queryItems = self.queryItems
        
        guard let url = components.url else {
            fatalError("Invalid URL")
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = 20
        return urlRequest
    }
    
    var commonQueryItems: [URLQueryItem] {
        let apiKey = "35e39ba19c642a74198dc83e0374c5d2"
        let privateKey = "331dd17d8c63d24f6ca609ab71ab96d3c70e97ce"
        let timeStamp = "\(Date().timeIntervalSince1970)"
        let hash = MD5(string: "\(timeStamp)\(privateKey)\(apiKey)")
        
        return   [
            URLQueryItem(name: "ts", value: timeStamp),
            URLQueryItem(name: "hash", value: hash),
            URLQueryItem(name: "apikey", value: apiKey)
        ]
    }
   
    func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
        
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}





