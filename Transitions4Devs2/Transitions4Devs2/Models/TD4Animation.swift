//
//  TD4Animation.swift
//  Transitions4Devs2
//
//  Created by admin on 4/23/24.
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
