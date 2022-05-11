//
//  FavouritesList.swift
//  FavouritesExample
//
//  Created by Russell Gordon on 2022-04-04.
//

import SwiftUI

struct FavouritesList: View {
    // MARK: Stored properties
    
    // Needs a reference to the list of available flavours
    // This is a derived value, from the source of truth at the app level
    @Binding var availableFlavours: [IceCreamFlavour]
    
    // MARK: Computed properties
    var body: some View {
        
        Group {
            // Filters the list of available flavours,
            // showing only flavours that are marked as a favourite
            List(availableFlavours
                    .filter { currentFlavour in
                        // Returns "true" when the current flavour is, in fact, a favourite
                        return currentFlavour.isFavourite == true
                    }
            ) { flavour in

                // Show the cell for what must be a favourite flavour
                FlavourCell(currentFlavour: flavour,
                            availableFlavours: $availableFlavours)
                
            }

        }
        .navigationTitle("Favourites")
    }
}

struct FavouritesList_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesList(availableFlavours: .constant(testFlavoursList))
    }
}
