//
//  IceCreamFlavourStore.swift
//  FavouritesExample
//
//  Created by Russell Gordon on 2022-04-04.
//

import Foundation

// Handles _state_ of of the ice cream flavours data in use within the app, so this belongs in the ViewModels group
class IceCreamFlavoursStore: ObservableObject {
    
    // MARK: Stored properties
    @Published var flavours: [IceCreamFlavour]
    
    // Toggled when the contents of an existing flavour have changed
    // ie.: when a flavour is marked as a favourite or not
    @Published var favouriteStateChanged = false
        
    // MARK: Initializers
    init() {
        
        // Get a URL that points to the saved JSON data containing the list of flavours
        let filename = getDocumentsDirectory().appendingPathComponent(fileNameLabel)
                
        // Attempt to load from the JSON in the stored / persisted file
        do {
            
            // Load the raw data
            let data = try Data(contentsOf: filename)
            
            // What was loaded from the file?
            print("Got data from file, contents are:")
            print(String(data: data, encoding: .utf8)!)

            // Decode the data into Swift native data structures
            self.flavours = try JSONDecoder().decode([IceCreamFlavour].self, from: data)
            
        } catch {
            
            // What went wrong?
            print(error.localizedDescription)
            print("Could not load data from persisted file, initializing with default list of flavours from app bundle.")

            // Set list of flavours to the default list from the app bundle
            let url = Bundle.main.url(forResource: "flavours", withExtension: "json")!
            
            // Load the contents of the JSON file
            let data = try! Data(contentsOf: url)
            
            // Convert the data from the JSON file into the array
            flavours = try! JSONDecoder().decode([IceCreamFlavour].self, from: data)

        }
        
    }
    
    // MARK: Functions
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
            let data = try encoder.encode(self.flavours)
            
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

var testStore = IceCreamFlavoursStore()

