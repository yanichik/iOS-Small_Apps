//
//  ViewController.swift
//  MasterUICollectionViewFlow
//
//  Created by admin on 4/23/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let imageNamesArray = ["pencil","eraser","trash","folder","paperplane","archivebox","doc","clipboard","note","calendar","book","book.circle","magazine","graduationcap","book"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        configureCollectionView()
    }
    
    func configureCollectionView() {
//        collectionView.backgroundColor = .systemCyan
    }
}


// MARK: UICollectionView Delegate + DataSource
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNamesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.cellDisplayImage.image = UIImage(systemName: imageNamesArray[indexPath.row])
        
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(sender:)))
        imageTapRecognizer.cancelsTouchesInView = true
        
        let infoTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(infoTapped(sender:)))
        infoTapRecognizer.cancelsTouchesInView = true
        
        cell.cellDisplayImage.isUserInteractionEnabled = true
        cell.cellDisplayImage.addGestureRecognizer(imageTapRecognizer)
        
        cell.infoImage.isUserInteractionEnabled = true
        cell.infoImage.addGestureRecognizer(infoTapRecognizer)
        return cell
    }
    
    @objc func imageTapped(sender: UITapGestureRecognizer){
        print(sender.view as! UIImageView)
    }
    
    @objc func infoTapped(sender: UITapGestureRecognizer){
        print(sender.view as! UIImageView)
    }
    
//    @objc func imageTapped(sender: UITapGestureRecognizer) {
//        if let cell = sender.view?.superview as? ImageCollectionViewCell {
//            if let indexPath = collectionView.indexPath(for: cell) {
//                print("Image tapped at indexPath: \(indexPath)")
//            }
//        }
//    }
//    
//    @objc func infoTapped(sender: UITapGestureRecognizer) {
//        if let cell = sender.view?.superview as? ImageCollectionViewCell {
//            if let indexPath = collectionView.indexPath(for: cell) {
//                print("Info tapped at indexPath: \(indexPath)")
//            }
//        }
//    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("\(imageNamesArray[indexPath.row]) selected")
//    }
}

// MARK: UICollectionView Delegate Flow Layout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30, left: 10, bottom: 30, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = collectionView.frame.width
        let cellWidth = (width - 30) / 3
        let cellHeight = cellWidth
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

