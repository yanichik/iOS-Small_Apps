//
//  A4DViewController.swift
//  Alerts4Devs
//
//  Created by Yan on 4/1/24.
//

import UIKit

// class A4DViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
class A4DViewController: UIViewController {
    var collectionView: UICollectionView!
    enum Section {
        case main
    }

    var dataSource: UICollectionViewDiffableDataSource<Section, A4DAnimation>!
    var animations: [A4DAnimation]!
    
    @IBAction func animateButton(_ sender: A4DAnimationButton) {
        guard let animation = sender.animation else { return }
        buttonPressed(sender, animation.type, animation.subtype)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAnimations()
        configureCollectionView()
        configureDataSource()
    }

    func configureAnimations() {
        let fadeFromTop = A4DAnimation(title: "fadeFromTop", type: .fade, subtype: .fromTop)
        let fadeFromBottom = A4DAnimation(title: "fadeFromBottom", type: .fade, subtype: .fromBottom)
        let fadeFromLeft = A4DAnimation(title: "fadeFromLeft", type: .fade, subtype: .fromLeft)
        let fadeFromRight = A4DAnimation(title: "fadeFromRight", type: .fade, subtype: .fromRight)
        let moveInFromTop = A4DAnimation(title: "moveInFromTop", type: .moveIn, subtype: .fromTop)
        let moveInFromBottom = A4DAnimation(title: "moveInFromBottom", type: .moveIn, subtype: .fromBottom)
        let moveInFromLeft = A4DAnimation(title: "moveInFromLeft", type: .moveIn, subtype: .fromLeft)
        let moveInFromRight = A4DAnimation(title: "moveInFromRight", type: .moveIn, subtype: .fromRight)
        let pushFromTop = A4DAnimation(title: "pushFromTop", type: .push, subtype: .fromTop)
        let pushFromBottom = A4DAnimation(title: "pushFromBottom", type: .push, subtype: .fromBottom)
        let pushFromLeft = A4DAnimation(title: "pushFromLeft", type: .push, subtype: .fromLeft)
        let pushFromRight = A4DAnimation(title: "pushFromRight", type: .push, subtype: .fromRight)
        let revealFromTop = A4DAnimation(title: "revealFromTop", type: .reveal, subtype: .fromTop)
        let revealFromBottom = A4DAnimation(title: "revealFromBottom", type: .reveal, subtype: .fromBottom)
        let revealFromLeft = A4DAnimation(title: "revealFromLeft", type: .reveal, subtype: .fromLeft)
        let revealFromRight = A4DAnimation(title: "revealFromRight", type: .reveal, subtype: .fromRight)

        animations = [
            fadeFromTop, fadeFromBottom, fadeFromLeft, fadeFromRight, moveInFromTop, moveInFromBottom, moveInFromLeft, moveInFromRight, pushFromTop, pushFromBottom, pushFromLeft, pushFromRight, revealFromTop, revealFromBottom, revealFromLeft, revealFromRight
        ]
        updateData()
    }

    @objc func buttonPressed(_ sender: UIButton, _ type: CATransitionType, _ subtype: CATransitionSubtype) {
        guard let titleText = sender.titleLabel?.text else { return }
        print("\(titleText) Pressed")
        
        let cell = collectionView.cellForItem(at: IndexPath(row: sender.tag, section: 0))
        
        let animation = CATransition()
        animation.startProgress = 0.0
        animation.endProgress = 1.0
        animation.duration = 1.0
        animation.type = type
        animation.subtype = subtype
        cell?.contentView.layer.add(animation, forKey: nil)
        cell?.contentView.backgroundColor = UIColor.blue.withAlphaComponent(0.2)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            cell?.contentView.backgroundColor = .systemPink
        }
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createTwoColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(A4DCollectionViewCell.self, forCellWithReuseIdentifier: "AnimationCell")
    }
    
    func createTwoColumnFlowLayout() -> UICollectionViewFlowLayout {
        let screenWidth = view.bounds.width
        let padding: CGFloat = 12
        let spaceBetweenItems: CGFloat = 20
        let availableWidth = screenWidth - (padding * 2) - spaceBetweenItems
        let itemWidth = availableWidth / 2
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        
        return flowLayout
    }
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, A4DAnimation>()
        snapshot.appendSections([.main])
        snapshot.appendItems(animations)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: {
            collectionView, indexPath, _ -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimationCell", for: indexPath) as! A4DCollectionViewCell
            
            let animation = self.animations[indexPath.row]
            
            var button: A4DAnimationButton!
            if let existingButton = cell.contentView.subviews.first(where: { $0 is A4DAnimationButton }) as? A4DAnimationButton {
                button = existingButton
            } else {
                button = A4DAnimationButton(type: .system, cell: cell, animation: animation, tag: indexPath.row)
                button.addTarget(self, action: #selector(self.animateButton(_:)), for: .touchUpInside)
            }
            
            cell.contentView.addSubview(button)
            
            return cell
        })
    }
}
