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
    var indicator = UIActivityIndicatorView()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator()
        tableView.dataSource = self
        tableView.delegate = self
        
        let nibName = UINib(nibName: "GameTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "gameCell")
        loadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    // MARK: Methods
    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.color = .darkGray
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    
    func loadData() {
        indicator.startAnimating()
        viewModel.loadData { [weak self] (_) in
            self?.tableView.reloadData()
            self?.indicator.stopAnimating()
        } errorHandler: { [weak self] (error: NetworkError) in
            self?.handleError(error: (self?.viewModel.errorCauched)!)
        }
        viewModel.loadDataFromCD()
    }
    
    func handleError(error: NetworkError) {
        let title: String = "Error".localized
        var message: String = "Something went wrong".localized
        switch error {
        case .networkError:
            message = "Please, check your Internet connection".localized
        case .unknown:
            message = "Unknown mistake".localized
        }
        let alert = AlertHelper.shared
        alert.show(for: self, title: title, message: message, leftButtonTitle: nil, rightButtonTitle: "OK", leftButtonAction: nil, rightButtonAction: nil)
    }
    
    func loadMoreItems() {
        viewModel.loadMoreData { [weak self] (_) in
            self?.tableView.beginUpdates()
            var array: [IndexPath] = []
            for i in self?.viewModel.paging ?? (0...0) {
                array.append(IndexPath.init(row: i, section: 0))
            }
            self?.tableView.insertRows(at: array, with: .none)
            self?.tableView.endUpdates()
        }
    }
    
    private func showMessage(title: String, message: String?) {
        let alert = AlertHelper.shared
        alert.show(for: self, title: title,
                   message: message,
                   leftButtonTitle: nil,
                   rightButtonTitle: "OK",
                   leftButtonAction: nil,
                   rightButtonAction: nil)
    }
}

//MARK: Extensions
extension GamesViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.gamesVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as? GameTableViewCell
        let games = viewModel.gamesVM[indexPath.row]
        cell?.config(model: games, indexOfCell: indexPath.row)
        cell?.saveAction = { [weak self] in
            self?.viewModel.saveUniqueGame(indexPath.row)
            self?.showMessage(title: "Game saved".localized, message: nil)
        }
        
        if viewModel.checkIsFavorite(id: games.id) == true {
            cell?.configIsFavorite()
        } else {
            cell?.configIsNotFavorite()
        }
    
        viewModel.loadImage(index: indexPath.row) { [weak self] image in
            DispatchQueue.main.async {
                if let cellTable = self?.tableView.cellForRow(at: indexPath) as? GameTableViewCell {
                    cellTable.addImage(image: image)
                }
            }
        }
        
        return cell ?? UITableViewCell()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height) {
            viewModel.isLoadingList = true
            loadMoreItems()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailedVC = DetailViewController()
        let game = viewModel.gamesVM[indexPath.row]
        detailedVC.gameViewModel = DetailViewModel(game: game)
        self.navigationController?.pushViewController(detailedVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("GamesListTableViewHeader", owner: nil, options: nil)?.first
        return headerView as? UIView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
}
