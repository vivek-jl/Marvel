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
    @Published var isLoading: Bool = false
    
    init(fetchCharacterUseCase: FetchCharacterUseCaseType = Resolver.resolve()) {
        self.fetchCharacterUseCase = fetchCharacterUseCase
    }

    func loadData() {
        guard !isLoading else { return }
        
        isLoading = true

        fetchCharacterUseCase.fetchCharacterPage()
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    print(error.errorDescription)
                }
            },
                  receiveValue: {[weak self] value in
                self?.characters += value
            }).store(in: &subscribers)
    }
}
