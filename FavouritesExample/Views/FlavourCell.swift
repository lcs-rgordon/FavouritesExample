//
//  FlavourCell.swift
//  FavouritesExample
//
//  Created by Russell Gordon on 2022-04-04.
//

import SwiftUI

struct FlavourCell: View {

    // MARK: Stored properties
    let currentFlavour: IceCreamFlavour
    
    // Needs a reference to the list of available flavours
    // This is a derived value, from the source of truth at the app level
    @Binding var availableFlavours: [IceCreamFlavour]
    
    // MARK: Computed properties
    var body: some View {
        HStack {
            //                   CONDITION                  when true : when false
            Image(systemName: currentFlavour.isFavourite ? "heart.fill" : "heart")
                .resizable()
                .frame(width: 20, height: 20)
                .scaledToFit()
                .padding(5)
                .foregroundColor(currentFlavour.isFavourite ? .red : .secondary)
                .onTapGesture {
                    
                    // Make a copy of this flavour, with favourite status changed to opposite
                    let copyOfCurrentFlavour = IceCreamFlavour(id: currentFlavour.id,
                                                               name: currentFlavour.name,
                                                               heroImage: currentFlavour.heroImage,
                                                               isFavourite: !currentFlavour.isFavourite)
                    
                    // Remove the current flavour from the list
                    // This iterates over the entire "availableFlavours" list, looking
                    // for a match to the current current flavour...
                    availableFlavours.removeAll(where: { currentFlavourInList in
                        currentFlavourInList.id == currentFlavour.id
                    })
                    
                    // Add this flavour again to the end of the list
                    availableFlavours.append(copyOfCurrentFlavour)

                    // Make a new list of the flavours, sorted by name
                    let newSortedListOfFlavours = availableFlavours
                                                    .sorted{ leftFlavour, rightFlavour in
                                                        leftFlavour.id < rightFlavour.id
                                                    }

                    // Remove all flavours from the existing list of available flavours
                    availableFlavours.removeAll()
                    
                    // Add the sorted list of flavours back in to the main list of available flavours
                    availableFlavours.append(contentsOf: newSortedListOfFlavours)
                    
                }
            
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
        FlavourCell(currentFlavour: testFlavour,
                    availableFlavours: .constant(testFlavoursList))
    }
    
}
