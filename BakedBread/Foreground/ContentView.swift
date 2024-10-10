//
//  ContentView.swift
//  BakedBread
//
//  Created by Matthew Smith on 10/6/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var newOvenFile = Oven(id: UUID(), name: "", author: "")
    
    @ObservedObject private var handler = FileHandler()
    
    var body: some View {
        VStack {
            if handler.openedOvenFile != nil {
                OvenEditor(file: handler.openedOvenFile!)
            } else {
                OvenEditor(file: newOvenFile)
            }
            
            Text(handler.saveStatus)
                .padding()
                .foregroundColor(.gray)
        }
        .padding()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
