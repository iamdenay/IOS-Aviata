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

class SoonMovieListViewController: BaseViewController, UITableViewDataSource {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        loadData()
    }
    
    fileprivate func loadData(){
        SVProgressHUD.show()
        MovieDBRepository().getUpcoming(){ res in
            SVProgressHUD.dismiss()
            self.movies = res
        }
    }
    
    fileprivate func configureViews(){
        view.addSubview(tableView)
    }
    
    fileprivate func configureConstraints(){
        tableView.easy.layout(
            Edges()
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
        cell.configure(movie: movies[indexPath.row], upcoming: true, vc:self)
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

