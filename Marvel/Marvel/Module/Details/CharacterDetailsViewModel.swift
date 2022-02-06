//
//  CharacterDetailsViewModel.swift
//  Marvel
//
//  Created by Vivek Jayakumar on 6/2/22.
//

import Foundation
import Combine
import Resolver

class CharacterDetailsViewModel: ObservableObject {
    @Published var character: Character?
    
    init(character: Character?) {
        self.character = character
    }
}
