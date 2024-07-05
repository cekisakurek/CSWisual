//
//  CSWisualDocument.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 25.06.24.
//

import SwiftUI
import UniformTypeIdentifiers

struct CSWisualDocument: FileDocument, Equatable {
    var text: String

    init(text: String = "") {
        self.text = text
    }

    static var readableContentTypes: [UTType] { [UTType.commaSeparatedText] }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        text = string
        
        
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = text.data(using: .utf8)!
        return .init(regularFileWithContents: data)
    }
}
