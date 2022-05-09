//
//  FlavoursList.swift
//  FavouritesExample
//
//  Created by Russell Gordon on 2022-04-04.
//

import SwiftUI

struct FlavoursList: View {
    
    // MARK: Stored properties
    
    // Needs a reference to the list of available flavours
    // This is a derived value, from the source of truth at the app level
    @Binding var availableFlavours: [IceCreamFlavour]

    // MARK: Computed properties
    var body: some View {
        List(availableFlavours
//             .sorted { leftFlavour, rightFlavour in
//                 leftFlavour.name > rightFlavour.name
//             }
        ) { flavour in
            FlavourCell(currentFlavour: flavour,
                        availableFlavours: $availableFlavours)
        }
        .navigationTitle("Flavours")
    }
}

struct FlavoursList_Previews: PreviewProvider {
    static var previews: some View {
        FlavoursList(availableFlavours: .constant(testFlavoursList))
    }
}
