//
//  FavouritesExampleApp.swift
//  FavouritesExample
//
//  Created by Russell Gordon on 2022-04-04.
//

import SwiftUI

@main
struct FavouritesExampleApp: App {
    
    // LocationStore is a reference type
    // It's created by this view
    // It's a source of truth, not a derived value
    // So, use @StateObject
    // Establishes an initial connection to the view model for locations
    @StateObject var store = IceCreamFlavoursStore()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                FlavoursList(store: store)
            }
        }
    }
}
