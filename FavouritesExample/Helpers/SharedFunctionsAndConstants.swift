//
//  SharedFunctionsAndConstants.swift
//  Reminders (iOS)
//
//  Created by Russell Gordon on 2022-01-24.
//

import Foundation

// Return the directory that we can save user data in
func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

// Define a file label (or file name) that we will write to within that directory
let fileNameLabel = "savedFlavours"
