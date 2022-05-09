//
//  FlavourCell.swift
//  FavouritesExample
//
//  Created by Russell Gordon on 2022-04-04.
//

import SwiftUI

struct FlavourCell: View {

    // MARK: Stored properties
    @State var currentFlavour: IceCreamFlavour
    
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
                    
                    // Change flavour's favourite status
                    currentFlavour.isFavourite.toggle()
                    
                    // Make a copy of this flavour
                    let copyOfCurrentFlavour = currentFlavour
                    
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

                    // Remove all flavours from the existing list of flavours
                    availableFlavours.removeAll()
                    
                    // Add the sorted list of flavours back in to the master list of flavours
                    availableFlavours.append(contentsOf: newSortedListOfFlavours)

                    // Used to ensure SwiftUI recomputes the view
                    // the shows the lists of favourite flavours
//                    withAnimation {
//                        store.favouriteStateChanged.toggle()
//                    }
                    
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
    
    /*
     "name": "Amazin Raisin",
     "heroImage": "Amazin-Raisin",
     "isFavourite": false,
     "id": 2
     */
    static var previews: some View {
        FlavourCell(currentFlavour: testFlavour,
                    availableFlavours: .constant(testFlavoursList))
    }
}
