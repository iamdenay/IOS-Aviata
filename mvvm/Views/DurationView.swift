import UIKit
import EasyPeasy
import Sugar
import ChameleonFramework

final class MovieCardView : UIView {

    fileprivate lazy var durationLabel = UILabel().then {
        $0.textColor = .flatWhite
        $0.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
        $0.numberOfLines = 1
        $0.textAlignment = .left
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configureViews(){
        backgroundColor = .flatBlackDark
        addSubviews(durationLabel)
    }
    
    fileprivate func configureConstraints(){
        durationLabel.easy.layout(
            Left(16),
            CenterY(),
            Right(16)
        )
    }
    
    func configure(movie:Movie){
        let h = movie.duration! / 60
        let m = movie.duration! % 60
        var genresString = ""
        for genre in movie.genres! {
            genresString += genre.name! + " "
        }
        durationLabel.text = "\(h)h \(m)m | " + genresString
    }
}
