//
//  FlavourCell.swift
//  FavouritesExample
//
//  Created by Russell Gordon on 2022-04-04.
//

import SwiftUI

struct FlavourCell: View {

    // MARK: Stored properties
    @ObservedObject var store: IceCreamFlavoursStore
    @ObservedObject var currentFlavour: IceCreamFlavour
    
    // MARK: Computed properties
    var body: some View {
        HStack {
            //                   CONDITION                  when true : when false
            Image(systemName: currentFlavour.isFavourite ? "heart.fill" : "heart")
                .resizable()
                .frame(width: 20, height: 20)
                .scaledToFit()
                .padding(5)
                .foregroundColor(currentFlavour.isFavourite ? .red : .secondary)
                .onTapGesture {
                    
                    // Change the object in the flavours store
                    currentFlavour.isFavourite.toggle()
                    
                    // Used to ensure SwiftUI recomputes the view
                    // the shows the lists of favourite flavours
                    withAnimation {
                        store.favouriteStateChanged.toggle()
                    }
                    
                }
            
            Image(currentFlavour.heroImage)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)

            
            VStack {
                Text(currentFlavour.name)
            }
            
            Spacer()
        }
    }
}

struct FlavourCell_Previews: PreviewProvider {
    static var previews: some View {
        FlavourCell(store: testStore,
                    currentFlavour: testStore.flavours.first!)
    }
}
