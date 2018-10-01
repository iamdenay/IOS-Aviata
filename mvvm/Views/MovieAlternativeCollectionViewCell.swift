import UIKit
import Reusable
import Sugar
import Kingfisher
import EasyPeasy
import ChameleonFramework

final class MovieAlternativeCollectionViewCell: UICollectionViewCell, Reusable {
    
    fileprivate lazy var posterImage = UIImageView().then {
        $0.contentMode = UIViewContentMode.scaleAspectFill
        $0.layer.masksToBounds=true;
        $0.isUserInteractionEnabled = true
    }
    
    fileprivate lazy var textLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont(name: "AppleSDGothicNeo-Light", size: 18)
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        configureViews()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configureViews() {
        contentView.backgroundColor = .flatBlack
        contentView.addSubviews(posterImage, textLabel)
        
    }
    
    fileprivate func configureConstraints() {
        posterImage.easy.layout(
            Top(0),
            Bottom(2).to(textLabel, .top),
            Left(8),
            Right(8)
        )
        
        textLabel.easy.layout([
            Left(0),
            Right(0),
            Bottom(8),
            Height(50)
        ])
    }
    
    func configure(movie:Movie, vc: UIViewController) {
        if let title = movie.title{
            textLabel.text = title
        }
        if let path = movie.posterPath{
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(String(describing: path))")
            posterImage.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholder"))
        } else {
            posterImage.image = #imageLiteral(resourceName: "placeholder")
        }

    }
    
    func configure(movie:Movie) {
        if let title = movie.title{
            textLabel.text = title
        }
        if let path = movie.posterPath{
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(String(describing: path))")
            posterImage.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholder"))
        } else {
            posterImage.image = #imageLiteral(resourceName: "placeholder")
        }
        
    }
    
}



