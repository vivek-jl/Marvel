//
//  ContentView.swift
//  Marvel
//
//  Created by Vivek Jayakumar on 3/2/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: CharactersViewModel
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.characters, id: \.self) { character in
                        VStack {
                            AnimatedImage(url: character?.thumbnail?.url)
                                .indicator(SDWebImageProgressIndicator.default)
                                .transition(SDWebImageTransition.fade)
                                .resizable()
                                .frame(width: geometry.size.width / 2.1,
                                       height:  geometry.size.width / 2)
                                .aspectRatio(contentMode: .fill)
                            Text(character?.name ?? "")
                                .font(.body)
                                .padding(.bottom, 5)
                        }
                        
                    }
                }
            }
        }
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
