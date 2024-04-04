//
//  A4DAnimation.swift
//  Alerts4Devs
//
//  Created by Yan on 4/4/24.
//

import UIKit

struct A4DAnimation: Hashable {
    var title: String
    var type: CATransitionType
    var subtype: CATransitionSubtype

    init(title: String, type: CATransitionType, subtype: CATransitionSubtype) {
        self.title = title
        self.type = type
        self.subtype = subtype
    }
}
