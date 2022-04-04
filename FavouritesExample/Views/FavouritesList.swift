//
//  FavouritesList.swift
//  FavouritesExample
//
//  Created by Russell Gordon on 2022-04-04.
//

import SwiftUI

struct FavouritesList: View {
    // MARK: Stored properties
    
    // Needs a reference to the store of locations
    // This is a derived value, from the source of truth at the app level
    // Provides a reference to the view model for locations
    @ObservedObject var store: IceCreamFlavoursStore

    // MARK: Computed properties
    var body: some View {
        
        // Only show flavours that are marked as a favourite
        List(store.flavours.filter({ currentFlavour in
            return currentFlavour.isFavourite
        })) { flavour in
            FlavourCell(store: store,
                        currentFlavour: flavour)
        }
        .navigationTitle("Favourites")
    }
}

struct FavouritesList_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesList(store: testStore)
    }
}
