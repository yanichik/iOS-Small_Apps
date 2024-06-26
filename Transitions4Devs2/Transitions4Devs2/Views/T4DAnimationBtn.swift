//
//  T4DAnimationBtn.swift
//  Transitions4Devs2
//
//  Created by admin on 4/23/24.
//

import UIKit

class T4DAnimationBtn: UIButton {
    var animation: T4DAnimation!
    init(type: UIButton.ButtonType, cell: UICollectionViewCell, animation: T4DAnimation, tag: IndexPath.Element) {
        super.init(frame: cell.contentView.bounds) // Ensure button fills cell's content view
        translatesAutoresizingMaskIntoConstraints = false

        self.animation = animation
        self.tag = tag // Contains row of IndexPath to pass on the animation associated with this

        setTitle(animation.title, for: .normal)
        autoresizingMask = [.flexibleWidth, .flexibleHeight] // Allow button to resize with cell
        titleLabel?.backgroundColor = .clear // Set label background color to clear
        setTitleColor(.black, for: .normal) // Set label text color
        titleLabel?.numberOfLines = 0 // Allow label to wrap multiple lines if needed
        titleLabel?.lineBreakMode = .byWordWrapping // Allow label to wrap at word boundaries
        titleLabel?.adjustsFontSizeToFitWidth = true // Adjust label font size to fit button's bounds
        titleLabel?.minimumScaleFactor = 0.5 // Minimum scale factor for label font size
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
