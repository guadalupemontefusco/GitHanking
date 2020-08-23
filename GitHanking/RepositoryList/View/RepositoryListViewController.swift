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
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200.0
        tableView.estimatedSectionFooterHeight = 200.0
        tableView.estimatedSectionHeaderHeight = 200.0
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? viewModel.numberOfRepos : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let items = viewModel.repositoriesList?.items,
            items.indices.contains(indexPath.row),
            indexPath.section == 0 else {
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
        guard let items = viewModel.repositoriesList?.items,
            indexPath.section == 0 else {
                return
        }
        
        if indexPath.row == items.count - pageIncrementFactor,
            shouldFetchMoreRepos {
            print(indexPath.row)
            nextPage += 1
            shouldFetchMoreRepos = false
            viewModel.getMostStarredRepos(nextPage: nextPage)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard section == 1 else { return nil }
        let footerView = LoadingFooterView(frame: CGRect(origin: .zero, size: CGSize(width: tableView.frame.width, height: 60)))
        return footerView
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard shouldFetchMoreRepos, section == 0 else { return nil }
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: tableView.frame.width, height: 70.0))
        view.backgroundColor = .crownYellowColor
        let label = UILabel(frame: view.frame)
        label.text = "GitHub star ranking for repositories"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        label.numberOfLines = 0
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8).isActive = true
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.numberOfRepos > 0 && section == 1 ? UITableView.automaticDimension : 0.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.numberOfRepos > 0 && section == 0 ? UITableView.automaticDimension : 0.0
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


