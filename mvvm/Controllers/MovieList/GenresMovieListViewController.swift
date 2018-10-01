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

class GenresMovieListViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var genre : Genre?
    
    fileprivate var movies = [Movie]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    fileprivate lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 150, height: 200)
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        configureConstraints()
        loadData()
        
        // Your action
    }
    
    fileprivate func loadData(){
        MovieDBRepository().getByGenre(identifier: genre!.id!){ res in
            self.movies = res
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as MovieAlternativeCollectionViewCell
        cell.configure(movie: movies[indexPath.item], vc:self)
        
        cell.contentView.tap { tap in
            SVProgressHUD.show()
            MovieDBRepository().getMovie(identifier: self.movies[indexPath.row].id!){ res in
                SVProgressHUD.dismiss()
                let vc = MovieDetailViewController()
                vc.movie = res
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 150, height: 200)
        
    }
    
    fileprivate func configureConstraints() {
        navigationItem.title = genre?.name
        view.backgroundColor = .flatBlack
        edgesForExtendedLayout = UIRectEdge()
        view.addSubviews(collectionView)
        collectionView.easy.layout(
            Edges(10)
        )
        
    }
}
