//
//  JSONParser.swift
//  MarvelTests
//
//  Created by Vivek Jayakumar on 03/02/22.

import Foundation

class JSONParser {
    func parseJSONfile<T: Decodable>(_ fileName: String, model: T.Type) -> T? {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: fileName,
                                   withExtension: "json") else {
            return nil
        }
       do {
           let json = try Data(contentsOf: url)
           let parsedData = try JSONDecoder()
               .decode(model.self, from: json)
           return parsedData
       } catch {
           return nil
       }
      
    }
}
