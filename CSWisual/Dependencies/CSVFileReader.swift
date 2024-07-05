//
//  CSVReader.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 26.06.24.
//
import Foundation
import ComposableArchitecture
import CSV

enum CSVFileReaderError: Swift.Error {
    case cannotOpenStream
}

struct CSVFileReader {
    let readFromURL: (URL, UnicodeScalar) async throws -> CSVData
}

extension CSVFileReader: DependencyKey {
    static var liveValue = Self { url, delimiter in

        let hasHeader = true

        guard let stream = InputStream(url: url)
        else {
            throw CSVFileReaderError.cannotOpenStream
        }
        let reader = try CSVReader(
            stream: stream,
            hasHeaderRow: hasHeader,
            delimiter: delimiter
        )

        let raw = reader.map( { $0 })

        let parsed = reader.headerRow?.enumerated().map { index, name  in
            let data = raw.map({ $0[index] })
            let column = CSVData.Column(name: name, data: data)
            return column
        }

        return CSVData(raw: raw, headers: reader.headerRow ?? [], columns: parsed ?? [])
    }

    static var testValue: CSVFileReader = Self(
        readFromURL: { url, delimiter in

            let hasHeader = true

            guard let stream = InputStream(url: url)
            else {
                throw CSVFileReaderError.cannotOpenStream
            }
            let reader = try CSVReader(
                stream: stream,
                hasHeaderRow: hasHeader,
                delimiter: delimiter
            )

            let raw = reader.map( { $0 })

            let parsed = reader.headerRow?.enumerated().map { index, name  in
                let data = raw.map({ $0[index] })
                let column = CSVData.Column(name: name, data: data)
                return column
            }

            return CSVData(raw: raw, headers: reader.headerRow ?? [], columns: parsed ?? [])
        }
    )
}

extension DependencyValues {
    var fileReader: CSVFileReader {
        get { self[CSVFileReader.self] }
        set { self[CSVFileReader.self] = newValue }
    }
}
