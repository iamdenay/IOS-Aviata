import UIKit
import EasyPeasy
import Reusable
import Lightbox
import Sugar
import Kingfisher

final class ImageCell: UICollectionViewCell, Reusable {
    
    lazy var image = UIImageView().then {
        $0.contentMode = UIViewContentMode.scaleAspectFill
        $0.layer.masksToBounds=true;
        $0.isUserInteractionEnabled = true
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
        contentView.backgroundColor = .white
        contentView.addSubviews(image)
    }
    
    fileprivate func configureConstraints() {
        image.easy.layout(
            Edges()
        )
    }
    
    func configure(url:String, vc:UIViewController) {
        
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(String(describing: url))")
        image.kf.setImage(with: url)
    }
    
}



