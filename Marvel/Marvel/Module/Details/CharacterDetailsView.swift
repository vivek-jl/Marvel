//
//  CharacterDetailsView.swift
//  Marvel
//
//  Created by Vivek Jayakumar on 6/2/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterDetailsView: View {
    
    @ObservedObject var viewModel: CharacterDetailsViewModel
    
    let rows: [GridItem] = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        GeometryReader { geomety in
            ScrollView {
                VStack {
                    AnimatedImage(url: viewModel.character?.thumbnail?.url)
                        .indicator(SDWebImageProgressIndicator.default)
                        .transition(SDWebImageTransition.fade)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geomety.size.width,
                               height: geomety.size.height / 2.5)
                        .clipped()
                    
                    if let description = viewModel.character?.description {
                        HStack {
                            Text(description)
                                .font(.body)
                            Spacer()
                        }.padding(16)
                    }
                    
                    HStack {
                        Text("Series")
                            .font(.title2)
                        Spacer()
                    }.padding(.horizontal, 16)
                    
                    VStack {
                        ForEach(viewModel.character?.series?.items ?? [], id: \.self) { comic in
                            HStack {
                                Text(comic.name ?? "")
                                    .font(.caption)
                                Spacer()
                            }
                            Divider()
                        }.padding(EdgeInsets(top: 5, leading: 16, bottom: 5, trailing: 16))
                    }
                    
                    HStack {
                        Text("Comics")
                            .font(.title2)
                        Spacer()
                    }.padding(.horizontal, 16)
                    
                    VStack {
                        ForEach(viewModel.character?.comics?.items ?? [], id: \.self) { comic in
                            HStack {
                                Text(comic.name ?? "")
                                    .font(.caption)
                                Spacer()
                            }
                            Divider()
                        }.padding(EdgeInsets(top: 5, leading: 16, bottom: 5, trailing: 16))
                    }
                    
                }
                
                Spacer()
            }
            
        }.padding(.top, 1)
            .navigationBarTitle(viewModel.character?.name ?? "", displayMode: .inline)
    }
    
}

struct CharacterDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailsView(viewModel: CharacterDetailsViewModel(character: nil))
    }
}
