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
    
    // The search term entered by the user
    @State var searchText = ""
    
    // MARK: Computed properties
    
    // When a search is active, returns only those flavours that match the search term
    var filteredListOfAvailableFlavours: [IceCreamFlavour] {

        if searchText.isEmpty {
            
            // If there is no search text entered, just return
            // all available flavours
            return availableFlavours
            
        } else {
            
            // Otherwise, filter the list of flavours so that
            // only those flavours that contain the search text are shown
            return availableFlavours
                    .filter { currentFlavour in
                        // Returns "true" when the current flavour's name contains the search term
                        // NOTE: Make all the text lowercased for a case-insensitive search
                        // When "true" is returned from this closure, the current flavour is shown
                        // in the filtered list
                        return currentFlavour.name.lowercased().contains(searchText.lowercased())
                    }
            
        }
    }
    
    // The body property (primary user interface
    var body: some View {
        	
        // Iterate over the list of  available flavours
        List(filteredListOfAvailableFlavours) { flavour in
            
            // Show a cell for the current flavour
            FlavourCell(currentFlavour: flavour,
                        availableFlavours: $availableFlavours)
            
            
        }
        .searchable(text: $searchText)
        .navigationTitle("Flavours")
    }
}

struct FlavoursList_Previews: PreviewProvider {
    static var previews: some View {
        FlavoursList(availableFlavours: .constant(testFlavoursList))
    }
}
