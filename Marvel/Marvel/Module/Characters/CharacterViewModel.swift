//
//  CharacterViewModel.swift
//  Marvel
//
//  Created by Vivek Jayakumar on 4/2/22.
//

import Foundation
import Combine
import Resolver

class CharactersViewModel: ObservableObject {
    
    private var subscribers = Set<AnyCancellable>()
    private var fetchCharacterUseCase: FetchCharacterUseCaseType
    
    @Published var characters: [Character] = []
    
    init(fetchCharacterUseCase: FetchCharacterUseCaseType = Resolver.resolve()) {
        self.fetchCharacterUseCase = fetchCharacterUseCase
    }

    func loadData() {
        fetchCharacterUseCase.fetchCharacterPage()
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print(error.errorDescription)
                }
            },
                  receiveValue: {[weak self] value in
                self?.characters = value
            }).store(in: &subscribers)
    }
}
