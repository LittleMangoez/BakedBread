//
//  OvenFileHandler.swift
//  BakedBread
//
//  Created by Matthew Smith on 10/10/24.
//

import Foundation
import SwiftUI

class FileHandler: ObservableObject {
    @Published var saveStatus: String = "" // Status for saving the file
    @Published var openedOvenFile: Oven?
    
    func openOvenFile(from fileURL: URL) -> Oven? {
        let fileManager = FileManager.default
        
        do {
            // Ensure the file exists
            guard fileManager.fileExists(atPath: fileURL.path) else {
                saveStatus = "File does not exist"
                return nil
            }
            
            // Read the data from the file
            let fileData = try Data(contentsOf: fileURL)
            
            // Decode the JSON data into an Oven object
            let oven = try JSONDecoder().decode(Oven.self, from: fileData)
            
            saveStatus = "File opened successfully"
            return oven
        } catch {
            saveStatus = "Failed to open file: \(error.localizedDescription)"
            return nil
        }
    }
    
    func saveTextAsOvenFile(text: String) {
        // Ensure text is not empty
        guard !text.isEmpty else {
            saveStatus = "No text to save"
            return
        }
        
        // Create file URL
        let fileName = "savedText.oven"
        let fileManager = FileManager.default
        
        do {
            // Get the document directory path
            let documentsURL = try fileManager.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false
            )
            let fileURL = documentsURL.appendingPathComponent(fileName)
            
            // Save the text to the file
            try text.write(to: fileURL, atomically: true, encoding: .utf8)
            
            saveStatus = "Saved successfully to \(fileURL.path)"
        } catch {
            saveStatus = "Failed to save file: \(error.localizedDescription)"
        }
    }
    
    func exportTextToDownloads(file: Oven) {
        // Ensure text is not empty
        guard !file.name.isEmpty else {
            saveStatus = "No text to export"
            return
        }
        
        let baseFileName = file.name.isEmpty ? "New Oven Operation" : file.name // Base name for the file
        
        let fileExtension = ".oven"
        let fileManager = FileManager.default
        
        do {
            // Get the URL for the Downloads directory
            let downloadsURL = try fileManager.url(
                for: .downloadsDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false
            )
            
            // Initialize file name
            var fileURL = downloadsURL.appendingPathComponent(baseFileName + fileExtension)
            
            // Check if a file already exists
            var counter = 1
            while fileManager.fileExists(atPath: fileURL.path) {
                let newFileName = "\(baseFileName)(\(counter))"
                fileURL = downloadsURL.appendingPathComponent(newFileName + fileExtension)
                counter += 1
            }
            
            // Write the text to the file
//            try file.write(to: fileURL, atomically: true, encoding: .utf8)
            
            // Encode the Oven object to JSON data
            let jsonData = try JSONEncoder().encode(file)
            
            // Write the JSON data to the file
            try jsonData.write(to: fileURL)
            
            saveStatus = "Exported successfully to \(fileURL.path)"
        } catch {
            saveStatus = "Failed to export file: \(error.localizedDescription)"
        }
    }
}
