//
//  ContentView.swift
//  Marvel
//
//  Created by Vivek Jayakumar on 3/2/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: CharactersViewModel
    @State private var isShowingDetailView = false
    @State private var selectedCharacter: Character? = nil
    @State private var searchText = ""
    
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    LazyVGrid(columns: columns) {
                        ForEach(searchResults, id: \.self) { character in
                            CharacterItemView(character: character)
                                .onTapGesture {
                                    isShowingDetailView = true
                                    selectedCharacter = character
                                }
                        }
                    }
                    
                    Button(action: viewModel.loadData) {
                        Text("Load More")
                    }
                }
                
                .background( NavigationLink(destination:
                                                CharacterDetailsView(
                                                    viewModel: CharacterDetailsViewModel(
                                                        character: selectedCharacter)),
                                            isActive: $isShowingDetailView) {
                    EmptyView()
                })
            }
            .searchable(text: $searchText)
            .navigationBarTitle("Marvel", displayMode: .inline)
            .onAppear {
                viewModel.loadData()
            }
        }
    }
    
    var searchResults: [Character] {
        if searchText.isEmpty {
            return viewModel.characters
        } else {
            return viewModel.characters.filter { $0.name.contains(searchText) }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: CharactersViewModel())
    }
}


extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
