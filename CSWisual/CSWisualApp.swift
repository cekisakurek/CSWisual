//
//  CSWisualApp.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 25.06.24.
//

import SwiftUI

@main
struct CSWisualApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: CSWisualDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
