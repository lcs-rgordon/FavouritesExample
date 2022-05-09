//
//  IceCreamFlavour.swift
//  FavouritesExample
//
//  Created by Russell Gordon on 2022-04-04.
//

import Foundation

struct IceCreamFlavour: Identifiable, Codable {
    
    // MARK: Stored properties
    let id: Int
    let name: String
    let heroImage: String
    var isFavourite: Bool
    
}

let testFlavour = IceCreamFlavour(id: 2, name: "Amazin Raisin", heroImage: "Amazin-Raisin", isFavourite: false)

let testFlavoursList = [
    
    IceCreamFlavour(id: 2, name: "Amazin Raisin", heroImage: "Amazin-Raisin", isFavourite: false)
    
    ,
    
    IceCreamFlavour(id: 3, name: "Banana", heroImage: "Banana", isFavourite: false)
    
    ,
    
    IceCreamFlavour(id: 4, name: "Baseball Nut", heroImage: "Baseball-Nut", isFavourite: true)
    
    ,
    
    IceCreamFlavour(id: 5, name: "Blue Raspberry Sherbet", heroImage: "Blue-Raspberry-Sherbet", isFavourite: true)
    
    ,
    
]
