//
//  GridCollectionViewLayout.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 26.06.24.
//

import Foundation
import UIKit
class GridCollectionViewLayout: UICollectionViewFlowLayout {

    let columnCount: Int
    let rowCount: Int
    
    init(columnCount: Int, rowCount: Int) {
        self.columnCount = columnCount
        self.rowCount = rowCount
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Collection view flow layout methods
    override var collectionViewContentSize: CGSize {
        return CGSize(width: CGFloat(columnCount) * self.itemSize.width, height: CGFloat(rowCount) * self.itemSize.height)
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        guard rowCount > 0 else { return [] }
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()

        let startY = max(Int(ceil((rect.minY)/self.itemSize.height)),0)
        
        
        // calculate next screen
        let endY = min(startY + Int(ceil(rect.height / self.itemSize.height)), rowCount)
        
        
        for row in startY..<endY {
            var xOffset: CGFloat = 100
            let yOffset: CGFloat = CGFloat(row) * self.itemSize.height
            for col in 0..<columnCount {
                
                let indexPath = IndexPath(row: row, column: col)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                
                if col == 0 {
                    var frame = attributes.frame
                    frame.origin.y = yOffset
                    frame.origin.x += collectionView!.contentOffset.x
                    frame.size = CGSize(width: 100.0, height: 50.0)
                    attributes.frame = frame
                    attributes.zIndex = 99
                    layoutAttributes.append(attributes)
                }
                else {
                    
                    attributes.frame = CGRect(x: xOffset, y: yOffset, width: itemSize.width, height: itemSize.height)
                    layoutAttributes.append(attributes)
                    xOffset += itemSize.width
                }
            }
        }
        
        // headers
        for col in 0..<columnCount {
            let headerIndexPath = IndexPath(row: 0, column: col)
            let headerAttributes = UICollectionViewLayoutAttributes(forCellWith: headerIndexPath)
            var frame = headerAttributes.frame
            frame.origin.y += collectionView!.contentOffset.y
            frame.origin.x = (CGFloat(col) * 100.0)
            frame.size = CGSize(width: 100.0, height: 50.0)
            headerAttributes.frame = frame
            headerAttributes.zIndex = 100
            layoutAttributes.append(headerAttributes)
        }
        
        
        // 0-0 is always there
        
        let headerIndexPath = IndexPath(row: 0, column: 0)
        let headerAttributes = UICollectionViewLayoutAttributes(forCellWith: headerIndexPath)
        var frame = headerAttributes.frame
        frame.origin.y += collectionView!.contentOffset.y
        frame.origin.x += collectionView!.contentOffset.x
        frame.size = CGSize(width: 100.0, height: 50.0)
        headerAttributes.frame = frame
        headerAttributes.zIndex = 105
        layoutAttributes.append(headerAttributes)
        
        
        
        return layoutAttributes
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
