//
//  CharacterItemView.swift
//  Marvel
//
//  Created by Vivek Jayakumar on 6/2/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterItemView: View {
    var character: Character
    
    var body: some View {
        VStack {
            AnimatedImage(url: character.thumbnail?.url)
                .indicator(SDWebImageProgressIndicator.default)
                .transition(SDWebImageTransition.fade)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .cornerRadius(15, corners: [.topLeft, .topRight])

            Text(character.name)
                .font(.body)
                .frame(minHeight: 50)
                .padding(5)
                
        }
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray, lineWidth: 1)
        )
        .padding(10)
    }
}
