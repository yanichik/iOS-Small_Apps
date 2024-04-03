//
//  ViewController.swift
//  Alerts4Devs
//
//  Created by Yan on 4/1/24.
//

import UIKit

// class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
class ViewController: UIViewController {
    var collectionView: UICollectionView!
    
    enum Section {
        case main
    }
    
    struct AnimationButton: Hashable {
        var button = UIButton(type: .system)
        var title: String
        var type: CATransitionType
        var subtype: CATransitionSubtype
        
        init(button: UIButton = UIButton(type: .system), title: String, type: CATransitionType, subtype: CATransitionSubtype) {
            self.button = button
            self.title = title
            self.type = type
            self.subtype = subtype
            self.button.setTitle(self.title, for: .normal)
        }
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, AnimationButton>!
    
    var animationButtons: [AnimationButton]!
    
    @IBAction func animateButton(_ sender: UIButton) {
        let animation = animationButtons[sender.tag]
        buttonPressed(sender, animation.type, animation.subtype)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAnimationButtons()
        configureCollectionView()
        configureDataSource()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.backgroundColor = .systemBackground
    }
    
    func configureAnimationButtons() {
        let fadeFromTop = AnimationButton(title: "fadeFromTop", type: .fade, subtype: .fromTop)
        let fadeFromBottom = AnimationButton(title: "fadeFromBottom", type: .fade, subtype: .fromBottom)
        let fadeFromLeft = AnimationButton(title: "fadeFromLeft", type: .fade, subtype: .fromLeft)
        let fadeFromRight = AnimationButton(title: "fadeFromRight", type: .fade, subtype: .fromRight)
        let moveInFromTop = AnimationButton(title: "moveInFromTop", type: .moveIn, subtype: .fromTop)
        let moveInFromBottom = AnimationButton(title: "moveInFromBottom", type: .moveIn, subtype: .fromBottom)
        let moveInFromLeft = AnimationButton(title: "moveInFromLeft", type: .moveIn, subtype: .fromLeft)
        let moveInFromRight = AnimationButton(title: "moveInFromRight", type: .moveIn, subtype: .fromRight)
        let pushFromTop = AnimationButton(title: "pushFromTop", type: .push, subtype: .fromTop)
        let pushFromBottom = AnimationButton(title: "pushFromBottom", type: .push, subtype: .fromBottom)
        let pushFromLeft = AnimationButton(title: "pushFromLeft", type: .push, subtype: .fromLeft)
        let pushFromRight = AnimationButton(title: "pushFromRight", type: .push, subtype: .fromRight)
        let revealFromTop = AnimationButton(title: "revealFromTop", type: .reveal, subtype: .fromTop)
        let revealFromBottom = AnimationButton(title: "revealFromBottom", type: .reveal, subtype: .fromBottom)
        let revealFromLeft = AnimationButton(title: "revealFromLeft", type: .reveal, subtype: .fromLeft)
        let revealFromRight = AnimationButton(title: "revealFromRight", type: .reveal, subtype: .fromRight)

        animationButtons = [
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
        animation.duration = 0.5
        animation.type = type
        animation.subtype = subtype
        cell?.contentView.layer.add(animation, forKey: nil)
        cell?.contentView.backgroundColor = UIColor.blue.withAlphaComponent(0.2)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            cell?.contentView.backgroundColor = .systemPink
        }
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createTwoColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "AnimationCell")
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
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnimationButton>()
        snapshot.appendSections([.main])
        snapshot.appendItems(animationButtons)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
//    func configureDataSource() {
//        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, _ -> UICollectionViewCell? in
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimationCell", for: indexPath)
//            cell.backgroundColor = .systemPink
//            let animation = self.animationButtons[indexPath.row]
//            let button = animation.button
//            button.backgroundColor = .systemGray
//            button.addTarget(self, action: #selector(self.buttonPressed(_:_:_:)), for: .touchUpInside)
//            button.titleLabel?.isHidden = false
//            cell.contentView.addSubview(button)
//            return cell
//        })
//    }
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, _ -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimationCell", for: indexPath)
            cell.backgroundColor = .systemPink
            cell.layer.cornerRadius = 20
            cell.contentView.layer.cornerRadius = 20
            
            let animation = self.animationButtons[indexPath.row]
            let button = animation.button
            
            button.tag = indexPath.row
            
            button.frame = cell.contentView.bounds // Ensure button fills cell's content view
            button.autoresizingMask = [.flexibleWidth, .flexibleHeight] // Allow button to resize with cell
            button.titleLabel?.backgroundColor = .clear // Set label background color to clear
            button.setTitleColor(.black, for: .normal) // Set label text color
            button.titleLabel?.numberOfLines = 0 // Allow label to wrap multiple lines if needed
            button.titleLabel?.lineBreakMode = .byWordWrapping // Allow label to wrap at word boundaries
            button.titleLabel?.adjustsFontSizeToFitWidth = true // Adjust label font size to fit button's bounds
            button.titleLabel?.minimumScaleFactor = 0.5 // Minimum scale factor for label font size
            
            button.addTarget(self, action: #selector(self.animateButton(_:)), for: .touchUpInside)
            cell.contentView.addSubview(button)
            
            return cell
        })
    }

}
