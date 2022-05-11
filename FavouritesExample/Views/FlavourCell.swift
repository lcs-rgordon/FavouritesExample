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
                    
                    // NOTE: SwiftUI, using the @State or @Binding property wrapper, will only
                    // detect changes to a list when an item is ADDED or REMOVED from the list
                    //
                    // As a result, when we simply CHANGE a property of an item (in this example,
                    // marking it as a favourite) to get SwiftUI to see that change, we must...
                    //
                    // 1. Make a copy of the current item, but reverse the favourite status (true
                    //    becomes false, false becomes true).
                    //
                    // 2. Remove the original instance of the item from the favourites list.
                    //
                    // 3. Add the copy of the item back into the list (it will be placed at
                    //    the bottom of the list)
                    //
                    // 4. Make a copy of the favourites list, but sort the copy, so the item
                    //    ends up back in the correct position in the list.
                    //
                    // 5. Remove all the items from the original favourites list.
                    //
                    // 6. Using the contents of the sorted copy of the original favourites list, re-populate
                    //    the original favourites list.
                    //
                    // NEEDLESS TO SAY... this is very tedious and not very efficient.
                    //
                    // In the Grade 12 Computer Science course, you will learn a much more elegant (and
                    // efficient) approach to handling a situation like this.
                    
                    // 1.
                    // Make a copy of this flavour, with the favourite status
                    // changed to the opposite of what is was previously
                    let copyOfCurrentFlavour = IceCreamFlavour(id: currentFlavour.id,
                                                               name: currentFlavour.name,
                                                               heroImage: currentFlavour.heroImage,
                                                               isFavourite: !currentFlavour.isFavourite)
                    
                    // 2.
                    // Remove the current flavour from the list
                    // This iterates over the entire "availableFlavours" list, looking
                    // for a match to the current current flavour...
                    availableFlavours.removeAll(where: { currentFlavourInList in
                        currentFlavourInList.id == currentFlavour.id
                    })
                    
                    // 3.
                    // Add this flavour again to the end of the list
                    availableFlavours.append(copyOfCurrentFlavour)

                    // 4.
                    // Make a new list of the flavours, sorted by name
                    let newSortedListOfFlavours = availableFlavours
                                                    .sorted{ leftFlavour, rightFlavour in
                                                        // Alphabetical, by name, ascending
                                                        // e.g.: A is less than B, so A goes first...)
                                                        leftFlavour.name < rightFlavour.name
                                                    }
                    // 5.
                    // Remove all flavours from the existing list of available flavours
                    availableFlavours.removeAll()
                    
                    // 6. 
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
