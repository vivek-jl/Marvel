//
//  MarvelApp.swift
//  Marvel
//
//  Created by Vivek Jayakumar on 3/2/22.
//

import SwiftUI
import Resolver

@main
struct MarvelApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: CharactersViewModel())
        }
    }
}

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register { APIClient(configuration: .default) as APIClientType }
        register { FetchCharacterUseCase(apiClient: Resolver.resolve())
            as FetchCharacterUseCaseType }
    }
}
