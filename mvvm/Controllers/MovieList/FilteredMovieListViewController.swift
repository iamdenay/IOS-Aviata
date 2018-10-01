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
import Sugar
import SVProgressHUD

class FilteredMovieListViewController: BaseViewController, UITableViewDataSource {
    
    
    fileprivate var movies = [Movie]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    fileprivate lazy var tableView: UITableView = {
        return UITableView().then {
            $0.register(cellType: MovieCell.self)
            $0.dataSource = self
            $0.rowHeight = UITableViewAutomaticDimension
            $0.estimatedRowHeight = 210
            $0.rowHeight = 210
            $0.tableFooterView = UIView()
            $0.separatorStyle = .none
            $0.allowsSelection = false
            $0.sectionHeaderHeight = 70
            $0.backgroundColor = .flatBlack
        }
    }()
    
    fileprivate lazy var startDateTF: UITextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: "Start Date",
                        attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        $0.textColor = .white
        $0.font = UIFont(name: "AppleSDGothicNeo-Light", size: 16)
        $0.keyboardType = .numberPad
        $0.backgroundColor = .flatBlack
        $0.layer.cornerRadius = 5.0
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.flatWhite.cgColor
    }
    
    fileprivate lazy var endDateTF: UITextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: "End Date",
                                                      attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        $0.textColor = .white
        $0.font = UIFont(name: "AppleSDGothicNeo-Light", size: 16)
        $0.keyboardType = .numberPad
        $0.backgroundColor = .flatBlack
        $0.layer.cornerRadius = 5.0
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.flatWhite.cgColor
    }
    
    fileprivate lazy var findBtn: UIButton = {
        return UIButton(type: .system).then {
            $0.backgroundColor = UIColor.flatGreen
            $0.setTitleColor(UIColor.white, for: .normal)
            $0.layer.cornerRadius = 5
            $0.setTitle("Find", for: .normal)
            $0.on(.touchUpInside) { _ in
                self.loadData()
            }
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
    }
    
    fileprivate func loadData(){
        guard let min = startDateTF.text, let max = endDateTF.text, !min.isEmpty, !max.isEmpty else {
                let alert = UIAlertController(title: "", message: "Нужно заполнить все поля", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
        }
        MovieDBRepository().getFilteredByYear(min: Int(min)!, max: Int(max)!){ res in
            self.movies = res
        }
    }
    
    fileprivate func configureViews(){
        navigationItem.title = "Movies"
        view.addSubviews(tableView, startDateTF, endDateTF, findBtn)
    }
    
    fileprivate func configureConstraints(){
        startDateTF.easy.layout(
            Top(24),
            Left(24),
            Right(12).to(endDateTF, .left),
            Width().like(endDateTF),
            Height(30)
        )
        endDateTF.easy.layout(
            Top(24),
            Left(12).to(startDateTF, .right),
            Right(12).to(findBtn, .left),
            Width().like(startDateTF),
            Height().like(startDateTF)
        )
        findBtn.easy.layout(
            Top(24),
            Left(12).to(endDateTF, .right),
            Right(24),
            Width().like(startDateTF),
            Height().like(startDateTF)
        )
        tableView.easy.layout(
            Left(),
            Right(),
            Top(24).to(startDateTF, .bottom),
            Bottom()
        )
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as MovieCell
        cell.contentView.backgroundColor = UIColor.flatBlack
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 10, y: 5, width: self.view.frame.size.width - 20, height: 200))
        
        whiteRoundedView.layer.backgroundColor = UIColor.flatBlack.cgColor
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 20.0
        whiteRoundedView.layer.shadowOffset = CGSize(width: 0, height: 0)
        whiteRoundedView.layer.shadowOpacity = 0
        whiteRoundedView.layer.borderWidth = 1
        whiteRoundedView.layer.borderColor = UIColor(red: 0.46, green: 0.46, blue: 0.46, alpha: 0.2).cgColor
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubview(toBack: whiteRoundedView)
        cell.configure(movie: movies[indexPath.row], upcoming: false, vc:self)
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
    
    
}

