//
//  IceCreamFlavour.swift
//  FavouritesExample
//
//  Created by Russell Gordon on 2022-04-04.
//

import Foundation

// Identify what properties should be read to and written from JSON
enum TaskCodingKeys: CodingKey {
    case id
    case name
    case heroImage
    case isFavourite
}

class IceCreamFlavour: Identifiable, Codable, ObservableObject {
    
    // MARK: Stored properties
    let id: Int
    let name: String
    let heroImage: String
    @Published var isFavourite: Bool
    
    // MARK: Initializers
    internal init(id: Int, name: String, heroImage: String, isFavourite: Bool) {
        self.id = id
        self.name = name
        self.heroImage = heroImage
        self.isFavourite = isFavourite
    }
    
    // MARK: Functions
    
    // Provide details for how to encode to JSON from an instance of this type
    func encode(to encoder: Encoder) throws {
        
        // Create a container that will be used to write an instance of the Task type to JSON
        var container = encoder.container(keyedBy: TaskCodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(heroImage, forKey: .heroImage)
        try container.encode(isFavourite, forKey: .isFavourite)

    }
    
    // Provide details for how to decode from JSON into an instance of this data type
    required init(from decoder: Decoder) throws {

        // Create a container that will be used to create instance of the Task type when decoding from JSON
        let container = try decoder.container(keyedBy: TaskCodingKeys.self)
        
        // Decode "id" property into an instance of the Int type
        self.id = try container.decode(Int.self, forKey: .id)
        // Decode "name" property into an instance of the String type
        self.name = try container.decode(String.self, forKey: .name)
        // Decode "heroImage" property into an instance of the String type
        self.heroImage = try container.decode(String.self, forKey: .heroImage)
        // Decode "isFavourite" property into an instance of the Bool type
        self.isFavourite = try container.decode(Bool.self, forKey: .isFavourite)
    }

}
