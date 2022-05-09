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
            // Only show flavours that are marked as a favourite
            List(availableFlavours
//                .sorted { leftFlavour, rightFlavour in
//                    leftFlavour.id > rightFlavour.id
//                }
                .filter { currentFlavour in
                    return currentFlavour.isFavourite
                }
            ) { flavour in
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
