//
//  T4DViewCell.swift
//  Transitions4Devs2
//
//  Created by admin on 4/23/24.
//

import UIKit

class T4DViewCell: UICollectionViewCell {
    @IBOutlet weak var infoImageView: UIImageView!
    @IBOutlet weak var animationImageView: UIImageView!
    @IBOutlet weak var slider: UISlider!
    
    var tapAction: (() -> Void)?
    var animaionName: String?
    var animationType: CATransitionType?
    var animationSubType: CATransitionSubtype?
    
    static let reuseID = "Cell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemPink
        layer.cornerRadius = 20
        contentView.layer.cornerRadius = 20
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let animationTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        animationImageView.isUserInteractionEnabled = true
        animationImageView.addGestureRecognizer(animationTapGesture)

        let infoTapGesture = UITapGestureRecognizer(target: self, action: #selector(infoTapped))
        infoImageView.isUserInteractionEnabled = true
        infoImageView.addGestureRecognizer(infoTapGesture)
    }
    
    @objc func imageTapped(){
        print("\(animationImageView.debugDescription) tapped")
        guard let type = animationType, let subType = animationSubType else { return }
        executeAnimation(type, subType)
    }
    
    @objc func infoTapped(){
        print("\(infoImageView.debugDescription) tapped")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let infoVC = storyboard.instantiateViewController(identifier: "InformationVC") as! T4DInformationVC
        ((superclass as! T4DCollectionVC).superclass as! UINavigationController).pushViewController(infoVC, animated: true)
        
    }
}

extension T4DViewCell {
    @objc func executeAnimation(_ type: CATransitionType, _ subtype: CATransitionSubtype) {
        guard let titleText = animaionName else { return }
        print("\(titleText) Pressed")
        
        let animation = CATransition()
        animation.startProgress = 0.0
        animation.endProgress = 1.0
        animation.duration = 1.0
        animation.type = type
        animation.subtype = subtype
        self.contentView.layer.add(animation, forKey: nil)
        UIView.animate(withDuration: 1.0) {
            self.contentView.backgroundColor = UIColor.blue.withAlphaComponent(CGFloat(self.slider.value))
        } completion: { _ in
            UIView.animate(withDuration: 1.0) {
                self.contentView.backgroundColor = .systemBackground
            }
        }
    }
}
