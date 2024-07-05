//
//  RawDataCollectionView.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 26.06.24.
//

import Foundation
import SwiftUI

struct RawAnalysisCollectionView: UIViewRepresentable {

    private let leftAndRightPaddings: CGFloat = 10.0

    static let cellReuseIdentifier = "collectionCell"

    let rows: [[String]]
    let headers: [String]
    let itemSize: CGSize
    let sectionInset: UIEdgeInsets
    var backgroundColor: UIColor

    var cellColor: UIColor = UIColor.white
    var cellColorAlt: UIColor = UIColor(red: 210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0, alpha: 1.0)

    init(
        rows: [[String]],
        headers: [String],
        itemSize: CGSize = CGSize(width: 100.0, height: 50.0),
        sectionInset: UIEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10),
        backgroundColor: UIColor = .white
    ) {
        self.rows = rows
        self.headers = headers
        self.itemSize = itemSize
        self.sectionInset = sectionInset
        self.backgroundColor = backgroundColor
    }

    func makeUIView(context: Context) -> UICollectionView {

        let rowCount = self.rows.count + 1
        let columnCount = self.headers.count + 1

        let flowLayout = GridCollectionViewLayout(columnCount: columnCount, rowCount: rowCount)
        flowLayout.minimumInteritemSpacing = self.leftAndRightPaddings/2.0
        flowLayout.sectionInset = self.sectionInset
        flowLayout.itemSize = self.itemSize

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)

        collectionView.register(RawDataCollectionViewCell.self,
                                forCellWithReuseIdentifier: RawAnalysisCollectionView.cellReuseIdentifier)
        collectionView.backgroundColor = self.backgroundColor
        collectionView.dataSource = context.coordinator

        return collectionView
    }

    func updateUIView(_ uiView: UICollectionView, context: Context) {
        context.coordinator.cellColor = self.cellColor
        context.coordinator.cellColorAlt = self.cellColorAlt
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(rows: rows, headers: headers, cellColor: cellColor, cellColorAlt: cellColorAlt)
    }

    class Coordinator: NSObject, UICollectionViewDataSource {
        let rows: [[String]]
        let headers: [String]

        var cellColor: UIColor
        var cellColorAlt: UIColor

        init(rows: [[String]], headers: [String], cellColor: UIColor, cellColorAlt: UIColor) {
            self.rows = rows
            self.headers = headers
            self.cellColor = cellColor
            self.cellColorAlt = cellColorAlt
        }

        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return rows.count + 1
        }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return headers.count + 1
        }

        func collectionView(_ collectionView: UICollectionView,
                            cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RawAnalysisCollectionView.cellReuseIdentifier,
                for: indexPath
            ) as? RawDataCollectionViewCell
            else { return UICollectionViewCell() }

            cell.backgroundColor = self.cellColor

            if indexPath.column == 0 {
                cell.backgroundColor = UIColor(
                    red: CGFloat(210.0/255.0),
                    green: CGFloat(210.0/255.0),
                    blue: CGFloat(210.0/255.0),
                    alpha: 1.0
                )
                if indexPath.row > 0 {
                    cell.setString(string: String(indexPath.row))
                } else {
                    cell.setString(string: NSLocalizedString("Row / Header", comment: ""))
                }
                return cell
            }

            if indexPath.row == 0 {
                cell.setString(string: headers[indexPath.column - 1])
                cell.backgroundColor = self.cellColorAlt
            } else {
                cell.setString(string: (rows[indexPath.row - 1][indexPath.column - 1] ))
            }
            return cell
        }
    }
}
