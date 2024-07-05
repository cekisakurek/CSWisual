//
//  DocumentPicker.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 25.06.24.
//
#if canImport(UIKit)
import Foundation
import SwiftUI
//import UIKit
import UniformTypeIdentifiers

struct DocumentPicker: UIViewControllerRepresentable {
 
    func makeUIViewController(context: Context) -> some UIViewController {
        let supportedTypes: [UTType] = [UTType.commaSeparatedText]
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)
//        picker.delegate = context.coordinator
        picker.allowsMultipleSelection = false
//        picker.modalPresentationStyle = .formSheet
        
        
//        let controller = UIDocumentPickerViewController(forOpeningContentTypes: [.text,.pdf])
//        controller.allowsMultipleSelection = false
//        controller.shouldShowFileExtensions = true
//        controller.delegate = context.coordinator
        return picker
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
//    func makeCoordinator() -> DocumentPickerCoordinator {
//        DocumentPickerCoordinator(projectVM: reportsViewModel, added: $added)
//    }
    
}
class DocumentPickerCoordinator: NSObject, UIDocumentPickerDelegate {


    override init() {

    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
//        guard let url = urls.first else {
//            return
//        }
       
    }
    
}
#endif
