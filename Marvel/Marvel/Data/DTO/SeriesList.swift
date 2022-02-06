//
//  SeriesList.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 07/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import Foundation

struct SeriesList: Codable, Hashable {
    
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [SeriesSummary]?
    
    enum CodingKeys: String, CodingKey {
        case available
        case returned
        case collectionURI
        case items
    }
}
