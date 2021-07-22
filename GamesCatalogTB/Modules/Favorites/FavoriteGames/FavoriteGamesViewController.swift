//
//  SecondViewController.swift
//  GamesCatalogTB
//
//  Created by Tsuprik Olga on 28.06.21.
//

import UIKit
import CoreData

class FavoriteGamesViewController: UIViewController {
    //MARK: Properties
    var viewModel = FavoriteViewModel()
    
    //MARK: IBOutlets
    @IBOutlet weak var favoriteGamesTableView: UITableView!
    @IBAction func deleteAll(_ sender: Any) {
        if viewModel.savedObjests == [] {
            showMessage(title: "You dont have saved games", message: nil, leftButtonTitle: nil, rightButtonTitle: "Ok", leftButtonAction: nil)
        } else {
            showMessage(title: "Are you sure you want delete all games?",message: nil, leftButtonTitle: "YES", rightButtonTitle: "No") {
                self.viewModel.deleteAll()
                self.favoriteGamesTableView.reloadData()
            }
        }
    }
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteGamesTableView.dataSource = self
        favoriteGamesTableView.delegate = self
        
        let nibName = UINib(nibName: "GameTableViewCell", bundle: nil)
        favoriteGamesTableView.register(nibName, forCellReuseIdentifier: "gameCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadData { [weak self] (_) in
            self?.favoriteGamesTableView.reloadData()
        }
    }
    
    private func showMessage(title: String, message: String?, leftButtonTitle: String?, rightButtonTitle: String, leftButtonAction: (() -> Void)?) {
        let alert = AlertHelper.shared
        alert.show(for: self, title: title, message: message, leftButtonTitle: leftButtonTitle, rightButtonTitle: rightButtonTitle, leftButtonAction: leftButtonAction, rightButtonAction: nil)
    }
}

//MARK: Extensions
extension FavoriteGamesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        viewModel.savedObjests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as? GameTableViewCell
        cell?.configFavoriteGame(model: viewModel.savedObjests[indexPath.row], indexOfCell: indexPath.row)

        viewModel.loadImage(index: indexPath.row) { [weak self] image in
            DispatchQueue.main.async {
                if let cellTable = self?.favoriteGamesTableView.cellForRow(at: indexPath) as? GameTableViewCell {
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
        showMessage(title: "Are you sure you want delete this game?", message: nil, leftButtonTitle: "YES", rightButtonTitle: "NO") {
            self.favoriteGamesTableView.beginUpdates()
            self.viewModel.deleteItem(index: indexPath.row)
            self.favoriteGamesTableView.deleteRows(at: [indexPath], with: .automatic)
            self.favoriteGamesTableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("FavoriteHeaderView", owner: nil, options: nil)?.first
        return headerView as? UIView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}

