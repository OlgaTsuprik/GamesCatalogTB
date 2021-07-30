//
//  DevelopersViewController.swift
//  GamesCatalogTB
//
//  Created by Оля on 27.07.2021.
//

import UIKit

class DevelopersViewController: UIViewController {
    
   //MARK: Outlets
    @IBOutlet weak var developersTableView: UITableView!
    
    // MARK: Properties
    var headerSize: CGFloat = 40
    var viewModel = DevelopersViewModel()
    var indicator = UIActivityIndicatorView()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator()
        developersTableView.dataSource = self
        developersTableView.delegate = self
        
        let nibName = UINib(nibName: "DeveloperTableViewCell", bundle: nil)
        developersTableView.register(nibName, forCellReuseIdentifier: "developerCell")
        loadData()
    }
    
    //MARK: Methods
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
            self?.developersTableView.reloadData()
            self?.indicator.stopAnimating()
            
        } errorHandler: { [weak self] (error: NetworkError) in
            self?.handleError(error: (self?.viewModel.errorCauched)!)
        }
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
            self?.developersTableView.beginUpdates()
            var array: [IndexPath] = []
            for i in self?.viewModel.paging ?? (0...0) {
                array.append(IndexPath.init(row: i, section: 0))
            }
            self?.developersTableView.insertRows(at: array, with: .none)
            self?.developersTableView.endUpdates()
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

extension DevelopersViewController:  UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.developersVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = developersTableView.dequeueReusableCell(withIdentifier: "developerCell", for: indexPath) as? DeveloperTableViewCell
        let developers = viewModel.developersVM[indexPath.row]
        cell?.config(model: developers, index: indexPath.row)
        
        viewModel.loadImage(index: indexPath.row) { [weak self] image in
            DispatchQueue.main.async {
                if let cellTable = self?.developersTableView.cellForRow(at: indexPath) as? DeveloperTableViewCell {
                    cellTable.addImage(image: image)
                }
            }
        }
        
        return cell ?? UITableViewCell()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((developersTableView.contentOffset.y + developersTableView.frame.size.height) >= developersTableView.contentSize.height) {
            viewModel.isLoadingList = true
            loadMoreItems()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("DevelopersTableViewHeader", owner: nil, options: nil)?.first
        
        return headerView as? UIView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return headerSize
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DeveloperDetailViewController()
        let developer = viewModel.developersVM[indexPath.row]
        vc.developerViewModel = DeveloperDetailViewModel(developer: developer)
        navigationController?.pushViewController(vc, animated: true)
    }
}
