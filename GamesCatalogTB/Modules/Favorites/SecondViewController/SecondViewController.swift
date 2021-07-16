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
    
    var savedObjests: [SavedGame] = []
    
    @IBOutlet weak var favoriteGamesTableView: UITableView!
    
//    @IBAction func readData(_ sender: Any) {
//        print("read")
//        CoreDataManager.shared.readDatawithName(name: "SavedGames")
//    }
//
//    @IBAction func deleteAll(_ sender: Any) {
//        CoreDataManager.shared.removeAll(withName: "SavedGames")
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteGamesTableView.dataSource = self
        favoriteGamesTableView.delegate = self
        
        let nibName = UINib(nibName: "FavoriteGameTableViewCell", bundle: nil)
        favoriteGamesTableView.register(nibName, forCellReuseIdentifier: "favoriteGameCell")
        let button = UIBarButtonItem(title: "DeleteAll", style: .done, target: #selector(deleteAll), action: .some(#selector(deleteAll)))
    
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = button
        
    }
    
    @objc func deleteAll() {
        print("deleted")
        CoreDataManager.shared.removeAll(withName: "SavedGame")
        favoriteGamesTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        savedObjests = CoreDataManager.shared.objects
        CoreDataManager.shared.getData()
       self.savedObjests = CoreDataManager.shared.objects
        favoriteGamesTableView.reloadData()
    }
    
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        savedObjests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteGameCell", for: indexPath) as? FavoriteGameTableViewCell
        cell?.config(model: savedObjests[indexPath.row], index: "\(indexPath.row + 1).")
        
        
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        favoriteGamesTableView.beginUpdates()
        
        favoriteGamesTableView.deleteRows(at: [indexPath], with: .automatic)
        CoreDataManager.shared.removeOne(withName: "SavedGame", id: savedObjests[indexPath.row].idString ?? "")
       
        savedObjests.remove(at: indexPath.row)
        favoriteGamesTableView.endUpdates()
        
    }
    
}
