//
//  Objects.swift
//  BakedBread
//
//  Created by Matthew Smith on 10/6/24.
//

import Foundation
import UniformTypeIdentifiers
import SwiftUI

struct Oven: Codable, Identifiable, Equatable {
    var id: UUID = UUID()
    var name: String
    var dateCreated = Date()
    var author: String
    
    init(id: UUID, name: String, dateCreated: Date = Date(), author: String) {
        self.id = id
        self.name = name
        self.dateCreated = dateCreated
        self.author = author
    }
}

struct TextFile: FileDocument {
    // tell the system we support only plain text
    static var readableContentTypes = [UTType.plainText]

    // by default our document is empty
    var text = "Custom Oven File"

    // a simple initializer that creates new, empty documents
    init(initialText: String = "Custom Oven") {
        text = initialText
    }

    // this initializer loads data that has been saved previously
    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            text = String(decoding: data, as: UTF8.self)
        }
    }

    // this will be called when the system wants to write our data to disk
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = Data(text.utf8)
        return FileWrapper(regularFileWithContents: data)
    }
}
