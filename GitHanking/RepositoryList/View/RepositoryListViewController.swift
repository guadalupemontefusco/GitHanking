//
//  RepositoryListViewController.swift
//  GitHanking
//
//  Created by Guadalupe Montefusco de Oliveira on 16/08/20.
//  Copyright © 2020 Guadalupe Montefusco de Oliveira. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

final class RepositoryListViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: RepositoryListViewModel!
    var refreshControl: CustomRefreshControl?
    
    // MARK: Initializers
    
    init(viewModel: RepositoryListViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDelegate = self

        setupTableView()
        setupRefreshControl()
        getMostStarredRepos()
    }
    
    // MARK: Convenience
    
    private func getMostStarredRepos() {
        viewModel.getMostStarredRepos()
        showLoading()
    }
    
    private func setupTableView() {
        tableView.register(with: BasicRepositoryInfoTableViewCell.self)
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 200.0
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setupRefreshControl() {
        refreshControl = CustomRefreshControl(screenBounds: UIScreen.main.bounds)
        refreshControl?.addTarget(self, action: #selector(self.refreshViewState), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func refreshViewState() {
        viewModel.repositoriesList = nil
        refreshControl?.endRefreshing()
        tableView.reloadData()
        getMostStarredRepos()
    }
}

extension RepositoryListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRepos
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let items = viewModel.repositoriesList?.items,
            items.indices.contains(indexPath.row) else {
            return UITableViewCell()
        }
        
        return tableView.dequeueReusableCell(of: BasicRepositoryInfoTableViewCell.self,
                                             for: indexPath, configure: { cell in
            let item = items[indexPath.row]
            cell.configure(with: item)
        })
    }
}

extension RepositoryListViewController: RepositoryListViewModelViewDelegate {

    func repositoryListViewModel(_ viewModel: RepositoryListViewModel,
                                 didGetReposListWith result: Result<RepositoriesList, GitHubError>) {
        tableView.reloadData()
        hideLoading()
    }
}


