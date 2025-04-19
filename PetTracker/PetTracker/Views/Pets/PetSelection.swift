//
//  PetSelection.swift
//  PetTracker
//
//  Created by Nyomi Bell on 4/17/25.
//

import SwiftUI

struct PetSelection: View {
    var body: some View {
        ScrollView(.vertical){
            LazyVStack(spacing: 15){
                CarouselView()
            }
        }
    }
    @ViewBuilder
    func CarouselView() -> some View{
        let spaceInt: CGFloat = 10
        
        ScrollView(.horizontal){
            HStack(spacing: spaceInt){
                ForEach(images){
                    model in Image(model.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                         .clipShape(.circle)
                         .frame(height: 380)

                }
            }
        }
        .frame(height: 380)
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
    }
}

#Preview {
    PetSelection()
}
