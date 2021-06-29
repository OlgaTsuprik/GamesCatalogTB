//
//  GamesViewController.swift
//  GamesCatalogTB
//
//  Created by Tsuprik Olga on 28.06.21.
//

import UIKit

class GamesViewController: UIViewController {
   // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    var viewModel = GamesViewModel()
    var network = NetworkingManager()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        let nibName = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "tableViewCell")
        loadData()
    }
    
    // MARK: Methods
    func loadData() {
        viewModel.loadData { (_) in
            self.tableView.reloadData()
        }
    }
    
    func loadMoreItems() {
        viewModel.loadMoreData { (_) in
            self.tableView.reloadData()
        }
    }
}

extension GamesViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.gamesVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as? TableViewCell
        let games = viewModel.gamesVM[indexPath.row]
        cell?.gameViewModel = games
        cell?.indexLabel.text = String(indexPath.row + 1) + "."
        cell?.selectionStyle = .none
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("HeaderViewTableViewCell", owner: nil, options: nil)?.first
        return headerView as? UIView
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        loadMoreItems()
        if ((tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height)
            && !network.isLoadingList
        {
            loadMoreItems()
            self.tableView.reloadData()
            print("reload")
            network.isLoadingList = true
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailedVC = DetailViewController()
        self.navigationController?.pushViewController(detailedVC, animated: true)
    }
}
