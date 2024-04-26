//
//  T4DCollectionVC.swift
//  Transitions4Devs2
//
//  Created by admin on 4/23/24.
//

import UIKit

private let reuseID = "Cell"
class T4DCollectionVC: UICollectionViewController {
    enum AnimationsEnum: String {
        case moveInFromTop
        case moveInFromBottom
        case moveInFromLeft
        case moveInFromRight
        case pushFromTop
        case pushFromBottom
        case pushFromLeft
        case pushFromRight
        
        var imageName: String {
            switch self {
            case .moveInFromTop:
                return "icloud.and.arrow.up.fill"
            case .moveInFromBottom:
                return "icloud.and.arrow.down"
            case .moveInFromLeft:
                return "delete.right"
            case .moveInFromRight:
                return "delete.left"
            case .pushFromTop:
                return "square.and.arrow.up"
            case .pushFromBottom:
                return "square.and.arrow.down"
            case .pushFromLeft:
                return "rectangle.portrait.and.arrow.right"
            case .pushFromRight:
                return "rectangle.lefthalf.inset.filled.arrow.left"
            }
        }
    }
    
    var animations: [T4DAnimation]!
    let animationImagesArray = ["icloud.and.arrow.up.fill", "icloud.and.arrow.down","delete.right", "delete.left", "square.and.arrow.up", "square.and.arrow.down", "rectangle.portrait.and.arrow.right", "rectangle.lefthalf.inset.filled.arrow.left"]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Transitions"
        configureAnimations()
//        configureCollectionView()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    func configureAnimations() {
//        let fadeFromTop = T4DAnimation(title: "fadeFromTop", type: .fade, subtype: .fromTop)
//        let fadeFromBottom = T4DAnimation(title: "fadeFromBottom", type: .fade, subtype: .fromBottom)
//        let fadeFromLeft = T4DAnimation(title: "fadeFromLeft", type: .fade, subtype: .fromLeft)
//        let fadeFromRight = T4DAnimation(title: "fadeFromRight", type: .fade, subtype: .fromRight)
        let moveInFromTop = T4DAnimation(title: "moveInFromTop", type: .moveIn, subtype: .fromTop)
        let moveInFromBottom = T4DAnimation(title: "moveInFromBottom", type: .moveIn, subtype: .fromBottom)
        let moveInFromLeft = T4DAnimation(title: "moveInFromLeft", type: .moveIn, subtype: .fromLeft)
        let moveInFromRight = T4DAnimation(title: "moveInFromRight", type: .moveIn, subtype: .fromRight)
        let pushFromTop = T4DAnimation(title: "pushFromTop", type: .push, subtype: .fromTop)
        let pushFromBottom = T4DAnimation(title: "pushFromBottom", type: .push, subtype: .fromBottom)
        let pushFromLeft = T4DAnimation(title: "pushFromLeft", type: .push, subtype: .fromLeft)
        let pushFromRight = T4DAnimation(title: "pushFromRight", type: .push, subtype: .fromRight)
//        let revealFromTop = T4DAnimation(title: "revealFromTop", type: .reveal, subtype: .fromTop)
//        let revealFromBottom = T4DAnimation(title: "revealFromBottom", type: .reveal, subtype: .fromBottom)
//        let revealFromLeft = T4DAnimation(title: "revealFromLeft", type: .reveal, subtype: .fromLeft)
//        let revealFromRight = T4DAnimation(title: "revealFromRight", type: .reveal, subtype: .fromRight)
        
        animations = [
            moveInFromTop, moveInFromBottom, moveInFromLeft, moveInFromRight, pushFromTop, pushFromBottom, pushFromLeft, pushFromRight
        ]
//        animations = [
//            moveInFromTop, moveInFromBottom, moveInFromLeft, moveInFromRight, pushFromTop, pushFromBottom, pushFromLeft, pushFromRight, revealFromTop, revealFromBottom, revealFromLeft, revealFromRight, fadeFromTop, fadeFromBottom, fadeFromLeft, fadeFromRight
//        ]
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return animations.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseID, for: indexPath) as! T4DViewCell
        let animation = animations[indexPath.row]
        let animationName = animation.title
        if let animationImageName = AnimationsEnum(rawValue: animationName)?.imageName {
            if let animationImage = UIImage(systemName: animationImageName){
                cell.animationImageView.image = animationImage
                cell.animaionName = animationName
                cell.animationType = animation.type
                cell.animationSubType = animation.subtype
            } else {
                cell.animationImageView.image = UIImage(systemName: animationImagesArray[0])
            }
        } else {
            cell.animationImageView.image = UIImage(systemName: animationImagesArray[0])
        }
        return cell
    }
    
//    @objc func executeAnimation(_ sender: UIButton, _ type: CATransitionType, _ subtype: CATransitionSubtype) {
//        guard let titleText = sender.titleLabel?.text else { return }
//        print("\(titleText) Pressed")
//        
//        let cell = collectionView.cellForItem(at: IndexPath(row: sender.tag, section: 0))
//        
//        let animation = CATransition()
//        animation.startProgress = 0.0
//        animation.endProgress = 1.0
//        animation.duration = 1.0
//        animation.type = type
//        animation.subtype = subtype
//        cell?.contentView.layer.add(animation, forKey: nil)
//        cell?.contentView.backgroundColor = UIColor.blue.withAlphaComponent(0.2)
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//            cell?.contentView.backgroundColor = .systemPink
//        }
//    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
