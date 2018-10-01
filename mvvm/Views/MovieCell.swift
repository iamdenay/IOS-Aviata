import UIKit
import EasyPeasy
import Reusable
import Lightbox
import Sugar
import Kingfisher
import UICircularProgressRing

final class MovieCell: UITableViewCell, Reusable {
    
    fileprivate lazy var posterImage = UIImageView().then {
        $0.contentMode = UIViewContentMode.scaleToFill
        $0.layer.masksToBounds=true;
        $0.isUserInteractionEnabled = true
    }
    
    fileprivate lazy var titleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont(name: "AppleSDGothicNeo-Light", size: 18)
        $0.numberOfLines = 2
        $0.textAlignment = .left
    }
    
    fileprivate lazy var overiewLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont(name: "AppleSDGothicNeo-Light", size: 14)
        $0.numberOfLines = 0
        $0.adjustsFontSizeToFitWidth = false
        $0.lineBreakMode = NSLineBreakMode.byTruncatingTail
        $0.textAlignment = .left
    }
    
    fileprivate lazy var votesLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont(name: "AppleSDGothicNeo-Light", size: 14)
        $0.numberOfLines = 0
        $0.textAlignment = .left
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func configureViews() {
        contentView.backgroundColor = .white
        contentView.addSubviews(titleLabel, posterImage, votesLabel, overiewLabel)
    }

    fileprivate func configureConstraints() {
        posterImage.easy.layout(
            Left(24),
            Top(24),
            Width((UIScreen.main.bounds.width)  * 0.3),
            Bottom(24)
        )
        
        titleLabel.easy.layout(
            Top(24),
            Left(24).to(posterImage,.right),
            Right(24)
        )
        
        overiewLabel.easy.layout(
            Top(16).to(titleLabel, .bottom),
            Left(24).to(posterImage, .right),
            Bottom(16).to(votesLabel, .top),
            Right(24)
        )
        
        votesLabel.easy.layout(
            Bottom(24),
            Right(24)
        )
    }

    func configure(movie:Movie,upcoming:Bool, vc:UIViewController) {
        titleLabel.text = movie.title
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(String(describing: movie.posterPath!))")
        posterImage.kf.setImage(with: url)
        overiewLabel.text = movie.overview!
        if !upcoming {
            votesLabel.text = "\(String(describing: movie.score!)) of \(String(describing: movie.votes!)) votes"
        }
    }
}



