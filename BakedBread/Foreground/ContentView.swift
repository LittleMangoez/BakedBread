//
//  ContentView.swift
//  BakedBread
//
//  Created by Matthew Smith on 10/6/24.
//

import SwiftUI

struct ContentView: View {
    @State private var textInput: String = "" // Input for user text
    @State private var saveStatus: String = "" // Status for saving the file
    
    var body: some View {
        VStack {
            TextField("Enter text to save", text: $textInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                saveTextAsOvenFile(text: textInput)
            }) {
                Text("Save as .oven")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            
            Button(action: {
                exportTextToDownloads(text: textInput)
            }) {
                Text("Export as .oven to Downloads")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            
            Text(saveStatus)
                .padding()
                .foregroundColor(.gray)
        }
        .padding()
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
    
    func exportTextToDownloads(text: String) {
        // Ensure text is not empty
        guard !text.isEmpty else {
            saveStatus = "No text to export"
            return
        }
        
        let baseFileName = "New Oven Operation" // Base name for the file
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
            try text.write(to: fileURL, atomically: true, encoding: .utf8)
            saveStatus = "Exported successfully to \(fileURL.path)"
        } catch {
            saveStatus = "Failed to export file: \(error.localizedDescription)"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
