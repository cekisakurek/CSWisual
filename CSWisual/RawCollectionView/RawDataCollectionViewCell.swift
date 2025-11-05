//
//  RawDataCollectionViewCell.swift
//  CSWisual
//
//  Created by Cihan Emre Kisakurek on 26.06.24.
//

import Foundation
import UIKit
class RawDataCollectionViewCell: UICollectionViewCell {

    private let label: UILabel

    override init(frame: CGRect) {

        self.label = UILabel(frame: .zero)
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.label.font = UIFont.systemFont(ofSize: 13)
        self.label.textAlignment = .center

        super.init(frame: frame)

        
        self.contentView.layer.borderWidth = 1.0

        self.contentView.addSubview(self.label)

        NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.label.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
    }
    
    func setBorderColor(_ color: UIColor) {
        self.contentView.layer.borderColor = color.cgColor
    }
    
    func setCellLabelColor(_ color: UIColor) {
        self.label.textColor = color
    }
    
    func setCellLabelFont(_ font: UIFont) {
        self.label.font = font
    }

    func setString(string: String?) {
        self.label.text = string
    }

    required convenience init?(coder aDecoder: NSCoder) {
        self.init(frame: .zero)
    }
}
