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
        components.queryItems = self.allQueryItems
        
        guard let url = components.url else {
            fatalError("Invalid URL")
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = 20
        return urlRequest
    }
    
    var commonQueryItems: [URLQueryItem] {
        let timeStamp = "\(Date().timeIntervalSince1970)"
        let hash = MD5(string: "\(timeStamp)\(APISecrets.privateKey)\(APISecrets.publicKey)")
        
        return   [
            URLQueryItem(name: "ts", value: timeStamp),
            URLQueryItem(name: "hash", value: hash),
            URLQueryItem(name: "apikey", value: APISecrets.publicKey)
        ]
    }
   
    func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
        
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}





