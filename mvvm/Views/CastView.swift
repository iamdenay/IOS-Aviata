//
//  DrawViewController.swift
//  Tennis
//
//  Created by Atabay Ziyaden on 24.10.17.
//  Copyright © 2017 IcyFlame Studios. All rights reserved.
//

import UIKit
import Reusable
import EasyPeasy
import Sugar
import SVProgressHUD
import ChameleonFramework
import Lightbox

class CastView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var cast = [Actor]() {
        didSet {
            collectionView.reloadData()
        }
    }
    fileprivate lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 140, height: 180)
        return layout
    }()
    
    fileprivate lazy var collectionView: UICollectionView = {
        return UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewLayout).then {
            $0.delegate = self
            $0.dataSource = self
            $0.allowsSelection = false
            $0.register(cellType: ActorCell.self)
            $0.backgroundColor = UIColor.flatBlack
        }
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as ActorCell
        cell.configure(actor: cast[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 140, height: 180)
        
    }
    
    fileprivate func configureConstraints() {
        backgroundColor = .black
        addSubviews(collectionView)
        collectionView.easy.layout(
            Edges()
        )
    }
}
