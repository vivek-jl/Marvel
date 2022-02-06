//
//  CharacterViewModel.swift
//  Marvel
//
//  Created by Vivek Jayakumar on 4/2/22.
//

import Foundation
import Combine

class CharactersViewModel: ObservableObject {
    
    private var subscribers = Set<AnyCancellable>()

    func loadData() {
        let apiClient = APIClient(configuration: .default)
        apiClient.request(type: CharacterDataWrapper.self, endpoint: MarvelCharacterEndpoint())
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print(error.errorDescription)
                }
            },
                  receiveValue: { value in
                print(value)
            }).store(in: &subscribers)
    }
}
