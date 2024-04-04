//
//  A4DCollectionViewCell.swift
//  Alerts4Devs
//
//  Created by Yan on 4/4/24.
//

import UIKit

class A4DCollectionViewCell: UICollectionViewCell {
    static let reuseID = "AnimationCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemPink
        layer.cornerRadius = 20
        contentView.layer.cornerRadius = 20
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
