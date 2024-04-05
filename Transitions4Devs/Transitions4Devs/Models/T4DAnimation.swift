//
//  T4DAnimation.swift
//  Transitions4Devs
//
//  Created by Yan on 4/4/24.
//

import UIKit

struct T4DAnimation: Hashable {
    var title: String
    var type: CATransitionType
    var subtype: CATransitionSubtype

    init(title: String, type: CATransitionType, subtype: CATransitionSubtype) {
        self.title = title
        self.type = type
        self.subtype = subtype
    }
}
