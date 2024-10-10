//
//  BakedBreadApp.swift
//  BakedBread
//
//  Created by Matthew Smith on 10/6/24.
//

import SwiftUI

let fm = FileManager.default
@usableFromInline let documentsDirectory = fm.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("com.littlemangoez.bakedbread")

@main
struct BakedBreadApp: App {
    @ObservedObject var handler = FileHandler()
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.commands {
            CommandGroup(after: .newItem) {
                Button("Open Operation") {
                    openFile()
                }
                .keyboardShortcut("O", modifiers: [.command])
            }
        }
    }
    
    // Function to open the file
        func openFile() {
            let openPanel = NSOpenPanel()
//            openPanel.allowedContentTypes = ["oven"]  // Only allow .oven files
            openPanel.allowsMultipleSelection = false
            openPanel.canChooseFiles = true
            
            openPanel.begin { response in
                if response == .OK, let selectedFileURL = openPanel.url {
                    if let openedOven = handler.openOvenFile(from: selectedFileURL) {
                        // Handle the opened Oven object here
                        print("Opened oven: \(openedOven)")
                        handler.openedOvenFile = openedOven
                    }
                }
            }
        }
}
