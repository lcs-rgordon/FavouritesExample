//
//  FlavoursList.swift
//  FavouritesExample
//
//  Created by Russell Gordon on 2022-04-04.
//

import SwiftUI

struct FlavoursList: View {
    
    // MARK: Stored properties
    
    // Needs a reference to the store of locations
    // This is a derived value, from the source of truth at the app level
    // Provides a reference to the view model for locations
    @ObservedObject var store: IceCreamFlavoursStore

    // MARK: Computed properties
    var body: some View {
        List(store.flavours) { flavour in
            FlavourCell(currentFlavour: flavour)
        }
        .navigationTitle("Flavours")
    }
}

struct FlavoursList_Previews: PreviewProvider {
    static var previews: some View {
        FlavoursList(store: testStore)
    }
}
