
import EasyPeasy
import SVProgressHUD
import Lightbox
import Segmentio
import ChameleonFramework

final class MovieMainViewController: BaseViewController {
    
    fileprivate lazy var rightButtonItem = UIBarButtonItem.init(
        barButtonSystemItem: UIBarButtonSystemItem.search,
        target: self,
        action: #selector(addTapped)
    )
    
    fileprivate lazy var containerView : UIView = {
        return UIView().then {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }()
    
    fileprivate var controller : UIViewController?
    
    fileprivate lazy var segmentioView: Segmentio = {
        return Segmentio().then{
            var indicator = SegmentioIndicatorOptions(
                type: .bottom,
                ratio: 1,
                height: 2,
                color: .white
            )
            var options = SegmentioOptions(
                backgroundColor: UIColor.flatBlack,
                scrollEnabled: true,
                indicatorOptions: indicator,
                horizontalSeparatorOptions: SegmentioHorizontalSeparatorOptions(
                    type: .bottom,
                    height: 0,
                    color: .clear
                ),
                verticalSeparatorOptions: SegmentioVerticalSeparatorOptions(
                    ratio: 0.1,
                    color: .clear
                ),
                imageContentMode: .center,
                labelTextAlignment: .center,
                labelTextNumberOfLines: 1,
                segmentStates: SegmentioStates(
                    defaultState: SegmentioState(
                        backgroundColor: .clear,
                        titleFont: UIFont(name: "AppleSDGothicNeo-Bold", size: 14)!,
                        titleTextColor: .white
                    ),
                    selectedState: SegmentioState(
                        backgroundColor: .clear,
                        titleFont: UIFont(name: "AppleSDGothicNeo-Bold", size: 14)!,
                        titleTextColor: .white
                    ),
                    highlightedState: SegmentioState(
                        backgroundColor: .clear,
                        titleFont: UIFont(name: "AppleSDGothicNeo-Bold", size: 12)!,
                        titleTextColor: .white
                    )
                ),
                animationDuration: 0.2
            )
            $0.setup(
                content:[SegmentioItem(title: "Popular", image: nil),SegmentioItem(title: "Upcoming", image: nil)],
                style: SegmentioStyle.onlyLabel,
                options: options
            )
            $0.selectedSegmentioIndex = 0
            
            $0.valueDidChange = { segmentio, segmentIndex in
                switch segmentIndex{
                case 0:
                    self.controller!.removeFromParentViewController()
                    self.controller! = PopularMovieListViewController()
                    self.addChildViewController(self.controller!)
                    self.containerView.addSubview(self.controller!.view)
                    self.navigationItem.rightBarButtonItem = self.rightButtonItem
                    self.controller!.didMove(toParentViewController: self)
                    
                case 1:
                    self.controller!.removeFromParentViewController()
                    self.controller! = SoonMovieListViewController()
                    self.addChildViewController(self.controller!)
                    self.containerView.addSubview(self.controller!.view)
                    self.navigationItem.rightBarButtonItem = self.rightButtonItem
                    self.controller!.didMove(toParentViewController: self)
                    
                default:
                    self.controller!.removeFromParentViewController()
                    self.controller! = PopularMovieListViewController()
                    self.addChildViewController(self.controller!)
                    self.containerView.addSubview(self.controller!.view)
                    self.navigationItem.rightBarButtonItem = self.rightButtonItem
                    self.controller!.didMove(toParentViewController: self)
                }
            }
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        controller = PopularMovieListViewController()
        addChildViewController(controller!)
        controller!.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(controller!.view)
        configureConstraints()
        controller!.didMove(toParentViewController: self)
        
    }
    
    
    
    fileprivate func configureViews() {
        self.navigationItem.rightBarButtonItem = rightButtonItem
        self.rightButtonItem.isEnabled = true
        view.addSubviews(segmentioView, containerView)
        navigationItem.title = "Movies"
    }
    
    fileprivate func configureConstraints() {
        segmentioView <- [
            Top(0),
            Left(0),
            Right(0),
            Height(50)
        ]
        containerView <- [
            Top(0).to(segmentioView, .bottom),
            Left(0),
            Right(0),
            Bottom(0)
        ]
        controller!.view <- [
            Top().to(containerView, .top),
            Left().to(containerView, .left),
            Right().to(containerView, .right),
            Bottom().to(containerView,.bottom)
        ]
    }
    
    @objc func addTapped(){
        let vc = MyTableViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


