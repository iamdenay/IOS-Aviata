import UIKit
import EasyPeasy
import Reusable
import Lightbox
import Sugar

final class GenreCell: UITableViewCell, Reusable {
    
    fileprivate lazy var titleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont(name: "AppleSDGothicNeo-Light", size: 18)
        $0.numberOfLines = 1
        $0.textAlignment = .left
    }
    
    fileprivate lazy var bottomSeparator = UIView().then {
        $0.backgroundColor = UIColor(red: 0.46, green: 0.46, blue: 0.46, alpha: 0.2)
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
        contentView.backgroundColor = .flatBlack
        contentView.addSubviews(titleLabel, bottomSeparator)
    }
    
    fileprivate func configureConstraints() {
        
        titleLabel.easy.layout(
            CenterY(),
            Left(24)
        )
        bottomSeparator.easy.layout(
            Left(0),
            Right(0),
            Bottom(0),
            Height(1)
        )
        
    }
    
    func configure(genre:Genre, vc:UIViewController) {
        titleLabel.text = genre.name
    }
    
    func configure(text:String?) {
        titleLabel.text = text
    }
}



