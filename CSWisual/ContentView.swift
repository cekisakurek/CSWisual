//
//  ContentView.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 25.06.24.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: CSWisualDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

#Preview {
    ContentView(document: .constant(CSWisualDocument()))
}
