//
//  Editor.swift
//  BakedBread
//
//  Created by Matthew Smith on 10/10/24.
//

import Foundation
import SwiftUI

struct OvenEditor: View {
    @State var file: Oven
    @ObservedObject private var handler = FileHandler()
    
    var body: some View {
        Text("Oven Editor")
        
        HStack {
            TextField("Name this operation", text: self.$file.name)
                .textFieldStyle(.plain)
                .padding()
            
            TextField("Author", text: self.$file.author)
                .textFieldStyle(.plain)
                .padding()
        }
        
        Button(action: {
            handler.exportTextToDownloads(file: file)
        }) {
            Text("Export as .oven to Downloads")
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        .padding()
    }
}
