//
//  ViewController.swift
//  Alerts4Devs
//
//  Created by Yan on 4/1/24.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func coverVerticalButton(_ sender: UIButton) {
        buttonPressed(sender, .moveIn, .fromBottom)
    }

    @IBOutlet var coverVerticalView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coverVerticalView.backgroundColor = .systemBackground
    }

    func buttonPressed(_ sender: UIButton, _ type: CATransitionType, _ subtype: CATransitionSubtype) {
        guard let titleText = sender.titleLabel?.text else { return }
        print("\(titleText) Pressed")
        let animation = CATransition()
        animation.duration = 0.5
        animation.type = type
        animation.subtype = subtype
        coverVerticalView.layer.add(animation, forKey: "pageCurlAnimation")
        coverVerticalView.backgroundColor = UIColor.blue.withAlphaComponent(0.2)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.coverVerticalView.backgroundColor = .systemBackground
        }
    }
}
