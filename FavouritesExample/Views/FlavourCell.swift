//
//  FlavourCell.swift
//  FavouritesExample
//
//  Created by Russell Gordon on 2022-04-04.
//

import SwiftUI

struct FlavourCell: View {
    
    @ObservedObject var currentFlavour: IceCreamFlavour
    
    var body: some View {
        HStack {
            Image(currentFlavour.heroImage)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)

            
            VStack {
                Text(currentFlavour.name)
            }
            
            Spacer()
        }
    }
}

struct FlavourCell_Previews: PreviewProvider {
    static var previews: some View {
        FlavourCell(currentFlavour: testStore.flavours.first!)
    }
}
