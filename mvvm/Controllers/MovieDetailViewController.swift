//
//  ViewController.swift
//  mvvm
//
//  Created by Atabay Ziyaden on 9/27/18.
//  Copyright © 2018 IcyFlame Studios. All rights reserved.
//

import UIKit
import EasyPeasy
import Reusable
import Alamofire
import AlamofireObjectMapper
import ChameleonFramework
import Sugar
import SVProgressHUD
import Lightbox

protocol SimilarViewDelegate {
    func didTapButton(id:Int)
}

class MovieDetailViewController: BaseViewController, SimilarViewDelegate {
    func didTapButton(id:Int) {
        SVProgressHUD.show()
        MovieDBRepository().getMovie(identifier: id){ res in
            SVProgressHUD.dismiss()
            let vc = MovieDetailViewController()
            vc.movie = res
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    var scrollView = UIScrollView()
    var contentView = UIView()
    var movie : Movie?
    
    var durationView = DurationView()
    var castView = CastView()
    var similarView = SimilarView()

    fileprivate lazy var castLabel = UILabel().then {
        $0.textColor = .flatWhiteDark
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold",size: 18)
        $0.numberOfLines = 1
        $0.textAlignment = .left
        $0.text = "Credits | Actors"
    }
    fileprivate lazy var similarLabel = UILabel().then {
        $0.textColor = .flatWhiteDark
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold",size: 18)
        $0.numberOfLines = 1
        $0.textAlignment = .left
        $0.text = "Similar Movies"
    }
    fileprivate lazy var posterImage = UIImageView().then {
        $0.contentMode = UIViewContentMode.scaleToFill
        $0.layer.masksToBounds=true;
        $0.isUserInteractionEnabled = true
    }

    fileprivate lazy var originalTitleLabel = UILabel().then {
        $0.textColor = .flatWhiteDark
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold",size: 14)
        $0.numberOfLines = 2
        $0.textAlignment = .left
    }
    
    fileprivate lazy var dateLabel = UILabel().then {
        $0.textColor = .flatWhite
        $0.font = UIFont(name: "AppleSDGothicNeo-Light", size: 14)
        $0.numberOfLines = 1
        $0.textAlignment = .left
    }
    
    fileprivate lazy var budgetLabel = UILabel().then {
        $0.textColor = .flatWhite
        $0.font = UIFont(name: "AppleSDGothicNeo-Light", size: 14)
        $0.numberOfLines = 1
        $0.textAlignment = .left
    }

    fileprivate lazy var votesLabel = UILabel().then {
        $0.textColor = .flatWhite
        $0.font = UIFont(name: "AppleSDGothicNeo-Light", size: 14)
        $0.numberOfLines = 0
        $0.textAlignment = .left
    }
    
    fileprivate lazy var overviewLabel = UILabel().then {
        $0.textColor = .flatWhite
        $0.font = UIFont(name: "AppleSDGothicNeo-Light", size: 16)
        $0.numberOfLines = 0
        $0.textAlignment = .left
    }
    
    fileprivate lazy var imagesButton: UIButton = {
        return UIButton(type: .system).then {
            $0.backgroundColor = UIColor.flatBlackDark
            $0.setTitleColor(UIColor.white, for: .normal)
            $0.layer.cornerRadius = 5
            $0.setTitle("See all Images", for: .normal)
            $0.on(.touchUpInside) { _ in
                self.allImages()
            }
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        loadData()
    }
    
    fileprivate func loadData(){
        if let movie = movie {
            navigationItem.title = movie.title

            if let path = movie.posterPath{
                let url = URL(string: "https://image.tmdb.org/t/p/w500\(String(describing: path))")
                posterImage.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholder"))
            } else {
                posterImage.image = #imageLiteral(resourceName: "placeholder")
            }
            dateLabel.text = movie.releaseDate
            budgetLabel.text = "Budget: \(String(describing: movie.budget!))"
            originalTitleLabel.text = movie.originalTitle
            overviewLabel.text = movie.overview
            for act : Actor in movie.actors! {
                print(act.name)
            }
        }
    }
    
    fileprivate func configureViews(){
        castView.cast = (movie?.actors)!
        similarView.movies = (movie?.similar)!
        similarView.delegate = self

        castView.backgroundColor = .white
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        posterImage.addGestureRecognizer(tapGestureRecognizer)
        durationView.configure(movie: movie!)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews( posterImage, dateLabel, budgetLabel, originalTitleLabel,overviewLabel, durationView, overviewLabel,
                                 imagesButton, castView, castLabel, similarView, similarLabel)
    }
    
    fileprivate func configureConstraints(){
        scrollView.easy.layout(
            Edges()
        )
        contentView.easy.layout(
            Top(),
            Left().to(self.view, .left),
            Right().to(self.view, .right),
            Bottom()
        )
        posterImage.easy.layout(
            Left(16),
            Top(16),
            Width((UIScreen.main.bounds.width)  * 0.3),
            Height((UIScreen.main.bounds.width)  * 0.45)
        )
        originalTitleLabel.easy.layout(
            Left(16).to(posterImage, .right),
            Top(16),
            Right(16)
        )
        budgetLabel.easy.layout(
            Left(16).to(posterImage, .right),
            Top(16).to(originalTitleLabel,.bottom),
            Right(16)
        )
        dateLabel.easy.layout(
            Left(16).to(posterImage, .right),
            Top(16).to(budgetLabel,.bottom),
            Right(16)
        )
        durationView.easy.layout(
            Left(0),
            Top(16).to(posterImage,.bottom),
            Right(0),
            Height(40)
        )
        imagesButton.easy.layout(
            Left(8),
            Right(8),
            Top(8).to(durationView, .bottom)
        )
        overviewLabel.easy.layout(
            Left(16),
            Top(8).to(imagesButton, .bottom),
            Right(16)
        )
        castLabel.easy.layout(
            Left(16),
            Top(8).to(overviewLabel, .bottom),
            Right(16)
        )
        castView.easy.layout(
            Left(16),
            Top(8).to(castLabel, .bottom),
            Right(16),
            Height(200)
        )
        similarLabel.easy.layout(
            Left(16),
            Top(8).to(castView, .bottom),
            Right(16)
        )
        similarView.easy.layout(
            Left(16),
            Top(8).to(similarLabel, .bottom),
            Right(16),
            Height(200),
            Bottom(0)
        )
        
    }
    
    fileprivate func allImages(){
        SVProgressHUD.show()
        MovieDBRepository().getImages(identifier: (self.movie?.id)!){ res in
            SVProgressHUD.dismiss()
            let vc = ImageCollectionView()
            vc.images = res
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        LightboxConfig.CloseButton.text = "Закрыть"
        
        LightboxConfig.CloseButton.textAttributes = [ NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): UIFont(name: "AppleSDGothicNeo-Light", size: 14)!]
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let lightboxImages = [tappedImage.image].map {
            return LightboxImage(image: $0 as! UIImage)
        }
        
        let lightbox = LightboxController(images: lightboxImages, startIndex: 0)
        present(lightbox, animated: true, completion: nil)
        // Your action
    }
}

