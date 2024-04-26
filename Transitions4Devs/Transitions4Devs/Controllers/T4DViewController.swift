//
//  T4DViewController.swift
//  Transitions4Devs
//
//  Created by Yan on 4/1/24.
//

import UIKit

class T4DViewController: UIViewController {
    var collectionView: UICollectionView!
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, T4DAnimation>!
    var animations: [T4DAnimation]!
    
    @IBAction func animateButton(_ sender: T4DAnimationButton) {
        guard let animation = sender.animation else { return }
        buttonPressed(sender, animation.type, animation.subtype)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Transitions"
        configureAnimations()
        configureCollectionView()
        configureDataSource()
    }
    
    func configureAnimations() {
        let fadeFromTop = T4DAnimation(title: "fadeFromTop", type: .fade, subtype: .fromTop)
        let fadeFromBottom = T4DAnimation(title: "fadeFromBottom", type: .fade, subtype: .fromBottom)
        let fadeFromLeft = T4DAnimation(title: "fadeFromLeft", type: .fade, subtype: .fromLeft)
        let fadeFromRight = T4DAnimation(title: "fadeFromRight", type: .fade, subtype: .fromRight)
        let moveInFromTop = T4DAnimation(title: "moveInFromTop", type: .moveIn, subtype: .fromTop)
        let moveInFromBottom = T4DAnimation(title: "moveInFromBottom", type: .moveIn, subtype: .fromBottom)
        let moveInFromLeft = T4DAnimation(title: "moveInFromLeft", type: .moveIn, subtype: .fromLeft)
        let moveInFromRight = T4DAnimation(title: "moveInFromRight", type: .moveIn, subtype: .fromRight)
        let pushFromTop = T4DAnimation(title: "pushFromTop", type: .push, subtype: .fromTop)
        let pushFromBottom = T4DAnimation(title: "pushFromBottom", type: .push, subtype: .fromBottom)
        let pushFromLeft = T4DAnimation(title: "pushFromLeft", type: .push, subtype: .fromLeft)
        let pushFromRight = T4DAnimation(title: "pushFromRight", type: .push, subtype: .fromRight)
        let revealFromTop = T4DAnimation(title: "revealFromTop", type: .reveal, subtype: .fromTop)
        let revealFromBottom = T4DAnimation(title: "revealFromBottom", type: .reveal, subtype: .fromBottom)
        let revealFromLeft = T4DAnimation(title: "revealFromLeft", type: .reveal, subtype: .fromLeft)
        let revealFromRight = T4DAnimation(title: "revealFromRight", type: .reveal, subtype: .fromRight)
        
        animations = [
            moveInFromTop, moveInFromBottom, moveInFromLeft, moveInFromRight, pushFromTop, pushFromBottom, pushFromLeft, pushFromRight, revealFromTop, revealFromBottom, revealFromLeft, revealFromRight, fadeFromTop, fadeFromBottom, fadeFromLeft, fadeFromRight
        ]
        updateData()
    }
    
    func configureCollectionView() {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createTwoColumnFlowLayout())
        scrollView.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(T4DCollectionViewCell.self, forCellWithReuseIdentifier: "AnimationCell")
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            collectionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
//        NSLayoutConstraint.activate([
//            info.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
//            info.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor, constant: 10)
//        ])
        
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
        var snapshot = NSDiffableDataSourceSnapshot<Section, T4DAnimation>()
        snapshot.appendSections([.main])
        snapshot.appendItems(animations)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: {
            collectionView, indexPath, _ -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimationCell", for: indexPath) as! T4DCollectionViewCell
            cell.contentView.subviews.forEach { subView in
                subView.removeFromSuperview()
            }
            let animation = self.animations[indexPath.row]
            
            let button = T4DAnimationButton(type: .system, cell: cell, animation: animation, tag: indexPath.row)
            button.addTarget(self, action: #selector(self.animateButton(_:)), for: .touchUpInside)
            
            guard let infoView = cell.infoView else { return UICollectionViewCell()}
            infoView.isUserInteractionEnabled = true
            
            let tapInfoGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapInfo))
            tapInfoGesture.cancelsTouchesInView = true
            
            cell.contentView.addSubview(button)
            cell.contentView.addSubview(infoView)
            
            return cell
        })
    }
    
    @objc func tapInfo(_ sender: UITapGestureRecognizer) {
        print("tapped info")
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
}
