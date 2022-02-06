//
//  MarvelApp.swift
//  Marvel
//
//  Created by Vivek Jayakumar on 3/2/22.
//

import SwiftUI

@main
struct MarvelApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: CharactersViewModel())
        }
    }
}
