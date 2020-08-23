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
    private var nextPage = 0
    private var shouldFetchMoreRepos = false
    private var pageIncrementFactor = 4
    private var refreshControl: CustomRefreshControl?
    
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
        viewModel.getMostStarredRepos(nextPage: nextPage)
        showLoading()
    }
    
    // MARK: Convenience
    
    private func setupTableView() {
        tableView.register(with: BasicRepositoryInfoTableViewCell.self)
        tableView.registerHeaderFooterView(with: LoadingFooterTableViewCell.self)
        tableView.estimatedRowHeight = 200.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedSectionFooterHeight = 200.0
        tableView.sectionFooterHeight = UITableView.automaticDimension
    }
    
    private func setupRefreshControl() {
        refreshControl = CustomRefreshControl(screenBounds: UIScreen.main.bounds,
                                              color: .bottomOrangeGradientColor)
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func refresh() {
        nextPage = 0
        viewModel.getMostStarredRepos(nextPage: nextPage)
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

extension RepositoryListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let items = viewModel.repositoriesList?.items else { return }
        
        if indexPath.row == items.count - pageIncrementFactor,
            shouldFetchMoreRepos {
            print(indexPath.row)
            nextPage += 1
            shouldFetchMoreRepos = false
            viewModel.getMostStarredRepos(nextPage: nextPage)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard shouldFetchMoreRepos else { return nil }
        let footerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: LoadingFooterTableViewCell.reuseIdentifier) as? LoadingFooterTableViewCell
        footerCell?.configureView()
        return footerCell
    }
}

extension RepositoryListViewController: RepositoryListViewModelViewDelegate {

    func repositoryListViewModel(_ viewModel: RepositoryListViewModel,
                                 didGetReposListWith result: Result<RepositoriesList, GitHubError>) {
        refreshControl?.endRefreshing()
        switch result {
        case .success(let list):
            shouldFetchMoreRepos = list.items.count != list.totalCount
        case .failure(let error):
            debugPrint(error) // TODO: handle error
        }
        tableView.reloadData()
        hideLoading()
    }
}


