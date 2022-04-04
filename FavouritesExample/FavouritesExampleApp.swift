//
//  FavouritesExampleApp.swift
//  FavouritesExample
//
//  Created by Russell Gordon on 2022-04-04.
//

import SwiftUI

@main
struct FavouritesExampleApp: App {
    
    // Detect when app moves between the foreground, background, and inactive states
    @Environment(\.scenePhase) var scenePhase
    
    // LocationStore is a reference type
    // It's created by this view
    // It's a source of truth, not a derived value
    // So, use @StateObject
    // Establishes an initial connection to the view model for locations
    @StateObject var store = IceCreamFlavoursStore()

    var body: some Scene {
        WindowGroup {
            
            TabView {
                
                NavigationView {
                    FlavoursList(store: store)
                }
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Flavours")
                }

                NavigationView {
                    FavouritesList(store: store)
                }
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favourites")
                }
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .inactive {
                
                print("Inactive")
                
            } else if newPhase == .active {
                
                print("Active")
                
            } else if newPhase == .background {
                
                print("Background")
                
                // Permanently save the list of ice cream flavours
                // NOTE: Must press Home screen button in simulator to background the app; re-compiling
                //       the app in Xcode and re-launching does not trigger the "Background" state in the iOS
                //       simulator for the old version of the app being replaced by the new version.
                store.persistFlavours()
                
            }
        }
    }
}
