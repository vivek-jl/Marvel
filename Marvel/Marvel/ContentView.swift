//
//  ContentView.swift
//  Marvel
//
//  Created by Vivek Jayakumar on 3/2/22.
//

import SwiftUI


struct ContentView: View {
    
    @ObservedObject var viewModel: CharactersViewModel
    
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                viewModel.loadData()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: CharactersViewModel())
    }
}
