//
//  SecondViewController.swift
//  GamesCatalogTB
//
//  Created by Tsuprik Olga on 28.06.21.
//

import UIKit
import CoreData


class SecondViewController: UIViewController {
    
    var viewModel = FavoriteViewModel()
    
    @IBOutlet weak var favoriteGamesTableView: UITableView!
    
    @IBAction func deleteAll(_ sender: Any) {
        print("deleted")
        viewModel.deleteAll()
        favoriteGamesTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteGamesTableView.dataSource = self
        favoriteGamesTableView.delegate = self
        
        let nibName = UINib(nibName: "FavoriteGameTableViewCell", bundle: nil)
        favoriteGamesTableView.register(nibName, forCellReuseIdentifier: "favoriteGameCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadData { [weak self] (_) in
            self?.favoriteGamesTableView.reloadData()
        }
        favoriteGamesTableView.reloadData()
    }
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.savedObjests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteGameCell", for: indexPath) as? FavoriteGameTableViewCell
        cell?.config(model: viewModel.savedObjests[indexPath.row], index: "\(indexPath.row + 1).")
        viewModel.loadImage(index: indexPath.row) { [weak self] image in
            DispatchQueue.main.async {
                if let cellTable = self?.favoriteGamesTableView.cellForRow(at: indexPath) as? FavoriteGameTableViewCell {
                    cellTable.addImage(image: image)
                }
            }
        }
        
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        favoriteGamesTableView.beginUpdates()
        favoriteGamesTableView.deleteRows(at: [indexPath], with: .automatic)
        viewModel.deleteItem(index: indexPath.row)
        favoriteGamesTableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("FavoriteHeaderView", owner: nil, options: nil)?.first
        return headerView as? UIView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}
