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

class ImageCollectionView: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var images : [MovieImage]?
    
    fileprivate lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 100, height: 100)
        return layout
    }()
    
    fileprivate lazy var collectionView: UICollectionView = {
        return UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewLayout).then {
            $0.delegate = self
            $0.dataSource = self
            $0.allowsSelection = false
            $0.register(cellType: ImageCell.self)
            $0.backgroundColor = UIColor.flatBlack
        }
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        configureConstraints()
        LightboxConfig.CloseButton.text = "Закрыть"

        LightboxConfig.CloseButton.textAttributes = [ NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): UIFont(name: "AppleSDGothicNeo-Light", size: 14)!]
        
        // Your action
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as ImageCell
        cell.configure(url: images![indexPath.item].filePath!, vc: self)
        
        cell.contentView.tap { tap in
            
            let tappedImage = cell.image
            let lightboxImages = [tappedImage.image].map {
                return LightboxImage(image: $0 as! UIImage)
            }
            
            let lightbox = LightboxController(images: lightboxImages, startIndex: 0)
            self.present(lightbox, animated: true, completion: nil)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 100, height: 100)
        
    }
    
    fileprivate func configureConstraints() {
        navigationItem.title = "Images"
        view.backgroundColor = .flatBlack
        edgesForExtendedLayout = UIRectEdge()
        view.addSubviews(collectionView)
        collectionView.easy.layout(
            Top(10),
            Bottom(10),
            Left(10),
            Right(10)
        )

    }
}
