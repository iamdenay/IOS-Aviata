import Foundation
import UIKit
import SVProgressHUD

class MyTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var history : [String]?

    fileprivate var movies = [Movie]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        if let temp = UserDefaults.standard.object(forKey: "history"){
            history = temp as! [String]
        } else {
            history = [String]()
        }

        view.backgroundColor = .flatBlack
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        super.viewDidLoad()
        tableView.register(cellType: GenreCell.self)
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = 50
        tableView.backgroundColor = .flatBlack
        tableView.separatorStyle = .none

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController.dismiss(animated: false, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if movies.count != 0 {
            return movies.count
        } else {
            return history!.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as GenreCell
        cell.contentView.backgroundColor = UIColor.flatBlack
        
        if movies.count != 0{
            let title = self.movies[indexPath.row].title!
            var date = self.movies[indexPath.row].releaseDate!
            date = String(date.prefix(4))
            cell.configure(text: "\(title) [\(date)]")
            cell.contentView.tap { tap in
                SVProgressHUD.show()
                MovieDBRepository().getMovie(identifier: self.movies[indexPath.row].id!){ res in
                    SVProgressHUD.dismiss()
                    if (self.history!.count == 20){
                        self.history!.remove(at: 0)
                    }
                    if !self.history!.contains { $0 == "\(title) [\(date)]" } {
                        self.history!.append("\(title) [\(date)]")
                    }
                    UserDefaults.standard.set(self.history, forKey: "history")
                    let vc = MovieDetailViewController()
                    vc.movie = res
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            }
            return cell
        } else {
            cell.configure(text: history![indexPath.row])
            cell.contentView.tap { tap in
                SVProgressHUD.show()
                MovieDBRepository().searchByName(query: String(self.history![indexPath.row].dropLast(7))){ res in
                    SVProgressHUD.dismiss()
                    self.movies = res
                }
            }
            return cell
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            MovieDBRepository().searchByName(query: searchText){ res in
                self.movies = res
            }
        }else {
            self.movies = [Movie]()
        }
    }
}
