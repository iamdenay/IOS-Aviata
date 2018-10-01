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

class GenreListViewController: BaseViewController, UITableViewDataSource {
    
    
    fileprivate var genres = [Genre]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    fileprivate lazy var tableView: UITableView = {
        return UITableView().then {
            $0.register(cellType: GenreCell.self)
            $0.dataSource = self
            $0.rowHeight = UITableViewAutomaticDimension
            $0.estimatedRowHeight = 64
            $0.tableFooterView = UIView()
            $0.separatorStyle = .singleLine
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
        MovieDBRepository().getGenres(){ res in
            self.genres = res
        }
    }
    
    fileprivate func configureViews(){
        navigationItem.title = "Жанры"
        view.addSubview(tableView)
    }
    
    fileprivate func configureConstraints(){
        tableView.easy.layout(
            Edges()
        )
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as GenreCell
        cell.configure(genre: genres[indexPath.row], vc:self)
        //        cell.contentView.tap { tap in
        //            let vc = CourtViewController()
        //            vc.court = self.courts[indexPath.row]
        //            self.navigationController?.pushViewController(vc, animated: true)
        //        }
        return cell
    }
    
    
}

