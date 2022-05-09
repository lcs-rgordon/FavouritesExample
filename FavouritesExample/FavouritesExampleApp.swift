//
//  FavouritesExampleApp.swift
//  FavouritesExample
//
//  Created by Russell Gordon on 2022-04-04.
//

import SwiftUI

@main
struct FavouritesExampleApp: App {
    
    // MARK: Stored properties
    
    // Detect when app moves between the foreground, background, and inactive states
    @Environment(\.scenePhase) var scenePhase
    
    // The source of truth for the list of ice cream flavours
    @State var availableFlavours: [IceCreamFlavour] = []

    // MARK: Computed properties
    var body: some Scene {
        
        WindowGroup {
            
            TabView {
                
                NavigationView {
                    FlavoursList(availableFlavours: $availableFlavours)
                }
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Flavours")
                }

                NavigationView {
                    FavouritesList(availableFlavours: $availableFlavours)
                }
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favourites")
                }
            }
            // Runs once when app opens
            .task {
                loadDataFromStorage()
            }
            
        }
        // Runs when app phase changes
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
                persistFlavours()
                
            }
        }
    }
    
    // MARK: Functions
    func loadDataFromStorage () {
        
        // Get a URL that points to the saved JSON data containing the list of flavours
        let filename = getDocumentsDirectory().appendingPathComponent(fileNameLabel)
                
        // Attempt to load from the stored / persisted file which is in JSON format
        do {
            
            // Load the raw data
            let data = try Data(contentsOf: filename)
            
            // What was loaded from the file?
            print("Got data from persisted file, contents are:")
            print(String(data: data, encoding: .utf8)!)

            // Decode the data into Swift native data structures
            availableFlavours = try JSONDecoder().decode([IceCreamFlavour].self, from: data)
            
            // What has been loaded into memory?
            print("Data from persisted file now in a list in memory, contents are:")
            print(dump(availableFlavours))
            
        } catch {
            
            // What went wrong?
            print(error.localizedDescription)
            print("Could not load data from persisted file, initializing with default list of flavours from app bundle.")

            // Set list of flavours to the default list from the app bundle
            let url = Bundle.main.url(forResource: "flavours", withExtension: "json")!
            
            // Load the contents of the JSON file
            let data = try! Data(contentsOf: url)
            
            // What was loaded from the app bundle?
            print("Got data from file in app bundle, contents are:")
            print(String(data: data, encoding: .utf8)!)
            
            // Convert the data from the JSON file into the array
            availableFlavours = try! JSONDecoder().decode([IceCreamFlavour].self, from: data)

            // What has been loaded into memory?
            print("Data from file in app bundle now in a list in memory, contents are:")
            print(dump(availableFlavours))

        }
        
    }
    
    // Save the list of available flavours
    func persistFlavours() {
        
        // Get a URL that points to the saved JSON data containing our list of tasks
        let filename = getDocumentsDirectory().appendingPathComponent(fileNameLabel)
        
        // Try to encode the data in our people array to JSON
        do {
            // Create an encoder
            let encoder = JSONEncoder()
            
            // Ensure the JSON written to the file is human-readable
            encoder.outputFormatting = .prettyPrinted
            
            // Encode the list of ice cream flavours
            let data = try encoder.encode(availableFlavours)
            
            // Actually write the JSON file to the documents directory
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
            
            // See the data that was written
            print("Saved data to documents directory successfully.")
            print("===")
            print(String(data: data, encoding: .utf8)!)
            
        } catch {
            
            print(error.localizedDescription)
            print("Unable to write list of flavours to documents directory in app bundle on device.")
            
        }
        
    }

    
}
