//
//  RepositoryListViewController.swift
//  GitHanking
//
//  Created by Guadalupe Montefusco de Oliveira on 16/08/20.
//  Copyright © 2020 Guadalupe Montefusco de Oliveira. All rights reserved.
//

import UIKit

final class RepositoryListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: RepositoryListViewModel?
    
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
        viewModel?.viewDelegate = self
        setupTableView()
        viewModel?.getMostStarredRepos()
    }
    
    // MARK: Convenience
    
    private func setupTableView() {
        let nib = UINib(nibName: "BasicRepositoryInfoTableViewCell", bundle: Bundle.main.self)
        tableView.register(nib, forCellReuseIdentifier: "BasicRepositoryInfoTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 200.0
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension RepositoryListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "BasicRepositoryInfoTableViewCell", for: indexPath)
    }
}

extension RepositoryListViewController: UITableViewDelegate {
    // TODO: Call UITableViewDelegate methods
}

extension RepositoryListViewController: RepositoryListViewModelViewDelegate {

    func repositoryListViewModel(_ viewModel: RepositoryListViewModel,
                                 didGetReposListWith result: Result<RepositoriesList, GitHubError>) {
        // TODO: Handle response
    }
}
