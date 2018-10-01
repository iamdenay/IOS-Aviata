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
import Tactile
import SVProgressHUD
import ChameleonFramework
import Lightbox

class SimilarView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var movies = [Movie]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var delegate: SimilarViewDelegate?

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
            $0.register(cellType: MovieAlternativeCollectionViewCell.self)
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
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as MovieAlternativeCollectionViewCell
        cell.configure(movie: movies[indexPath.item])
        cell.contentView.tap { tap in
            self.delegate?.didTapButton(id:  self.movies[indexPath.item].id!)
        }
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
