//
//  IceCreamFlavourStore.swift
//  FavouritesExample
//
//  Created by Russell Gordon on 2022-04-04.
//

import Foundation

// Handles _state_ of of the ice cream flavours data in use within the app, so this belongs in the ViewModels group
class IceCreamFlavoursStore: ObservableObject {
    
    var flavours: [IceCreamFlavour]
        
    init() {
        
        // Get a pointer to the file
        let url = Bundle.main.url(forResource: "flavours", withExtension: "json")!
        
        // Load the contents of the JSON file
        let data = try! Data(contentsOf: url)
        
        // Convert the data from the JSON file into the array
        flavours = try! JSONDecoder().decode([IceCreamFlavour].self, from: data)
        
    }
    
}

var testStore = IceCreamFlavoursStore()

