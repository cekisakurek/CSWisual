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

    var cellBackgroundColor: UIColor
    var cellLabelColor: UIColor
    var cellBorderColor: UIColor
    var headerColor: UIColor

    init(
        rows: [[String]],
        headers: [String],
        itemSize: CGSize = CGSize(width: 100.0, height: 50.0),
        sectionInset: UIEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10),
        backgroundColor: UIColor = .white,
        cellBackgroundColor: UIColor = .white,
        cellLabelColor: UIColor = .black,
        cellBorderColor: UIColor = .black,
        headerColor: UIColor = UIColor(red: 210.0/255.0, green: 210.0/255.0, blue: 210.0/255.0, alpha: 1.0)
    ) {
        self.rows = rows
        self.headers = headers
        self.itemSize = itemSize
        self.sectionInset = sectionInset
        self.backgroundColor = backgroundColor
        self.cellBackgroundColor = cellBackgroundColor
        self.cellLabelColor = cellLabelColor
        self.cellBorderColor = cellBorderColor
        self.headerColor = headerColor
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
        context.coordinator.cellBackgroundColor = self.cellBackgroundColor
        context.coordinator.cellLabelColor = self.cellLabelColor
        context.coordinator.headerColor = self.headerColor
        context.coordinator.cellBorderColor = self.cellBorderColor
        
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(rows: rows, headers: headers, cellBackgroundColor: cellBackgroundColor, cellLabelColor: cellLabelColor, cellBorderColor: cellBorderColor, headerColor: headerColor)
    }

    class Coordinator: NSObject, UICollectionViewDataSource {
        let rows: [[String]]
        let headers: [String]

        var cellBackgroundColor: UIColor
        var cellLabelColor: UIColor
        var cellBorderColor: UIColor
        var headerColor: UIColor

        init(rows: [[String]], headers: [String], cellBackgroundColor: UIColor, cellLabelColor: UIColor, cellBorderColor: UIColor, headerColor: UIColor) {
            self.rows = rows
            self.headers = headers
            self.cellBackgroundColor = cellBackgroundColor
            self.headerColor = headerColor
            
            self.cellLabelColor = cellLabelColor
            self.cellBorderColor = cellBorderColor
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

            
            cell.setBorderColor(self.cellBorderColor)
            cell.setCellLabelColor(self.cellLabelColor)
            if indexPath.column == 0 {
                cell.backgroundColor = self.headerColor
                cell.setCellLabelFont(UIFont.boldSystemFont(ofSize: 16))
                if indexPath.row > 0 {
                    cell.setString(string: String(indexPath.row))
                } else {
                    cell.setString(string: "")
                }
                return cell
            }

            if indexPath.row == 0 {
                cell.setString(string: headers[indexPath.column - 1])
                cell.backgroundColor = self.headerColor
                cell.setCellLabelFont(UIFont.boldSystemFont(ofSize: 16))
            } else {
                cell.setString(string: (rows[indexPath.row - 1][indexPath.column - 1] ))
                cell.backgroundColor = self.cellBackgroundColor
                cell.setCellLabelFont(UIFont.systemFont(ofSize: 16))
            }
            return cell
        }
    }
}
