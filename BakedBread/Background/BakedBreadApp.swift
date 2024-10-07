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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
