import UIKit
import EasyPeasy
import Reusable
import Sugar
import Kingfisher

final class ActorCell: UICollectionViewCell, Reusable {
    
    fileprivate lazy var image = UIImageView().then {
        $0.contentMode = UIViewContentMode.scaleAspectFill
        $0.layer.masksToBounds=true;
        $0.isUserInteractionEnabled = true
    }
    
    fileprivate lazy var nameLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont(name: "AppleSDGothicNeo-Light", size: 14)
        $0.numberOfLines = 1
        $0.textAlignment = .left
    }
    
    fileprivate lazy var charLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont(name: "AppleSDGothicNeo-Light", size: 12)
        $0.numberOfLines = 1
        $0.textAlignment = .left
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
        contentView.backgroundColor = .flatBlackDark
        contentView.addSubviews(image, nameLabel, charLabel)
        
    }
    
    fileprivate func configureConstraints() {
        image.easy.layout(
            Left(),
            Right(),
            Top(),
            Bottom(2).to(nameLabel, .top)
        )
        nameLabel.easy.layout(
            Left(0),
            Right(0),
            Bottom(2).to(charLabel, .top),
            Height(20)
        )
        charLabel.easy.layout(
            Left(0),
            Right(0),
            Bottom(0),
            Height(20)
        )
    }
    
    func configure(actor:Actor) {
        nameLabel.text = actor.name
        if let path = actor.profile_path{
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(String(describing: path))")
            image.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholder"))
        } else {
            image.image = #imageLiteral(resourceName: "placeholder")
        }
        charLabel.text = actor.character

    }
    
}



