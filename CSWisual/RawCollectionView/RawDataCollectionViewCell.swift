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

        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.layer.borderWidth = 1.0

        // TODO: implement dark/light theme
        if #available(iOS 13.0, *) {
            if self.traitCollection.userInterfaceStyle == .dark {
                self.label.textColor = UIColor.black
            } else {
                self.label.textColor = UIColor.black
            }
        } else {
            self.label.textColor = UIColor.white
        }
        self.contentView.addSubview(self.label)

        NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.label.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
    }

    func setString(string: String?) {
        self.label.text = string
    }

    required convenience init?(coder aDecoder: NSCoder) {
        self.init(frame: .zero)
    }
}
