//
//  RepositoryListViewModel.swift
//  GitHanking
//
//  Created by Guadalupe Montefusco de Oliveira on 22/08/20.
//  Copyright © 2020 Guadalupe Montefusco de Oliveira. All rights reserved.
//

import Moya

protocol RepositoryListViewModelViewDelegate: AnyObject {
    func repositoryListViewModel(_ viewModel: RepositoryListViewModel,
                                 didGetReposListWith result: Result<RepositoriesList, GitHubError>)
}

final class RepositoryListViewModel {

    let service = GitHubService()
    var repositoriesList: RepositoriesList?
    private let numberOfReposPerPage = 12
    weak var viewDelegate: RepositoryListViewModelViewDelegate?
    
    // MARK: Getters
    
    var numberOfRepos: Int {
        return repositoriesList?.items.count ?? 0
    }
    
    // MARK: Business logic
    
    func getMostStarredRepos() {
        let parametersList = ParametersList(language: .swift, sort: .stars, nextPage: 0,
                                            direction: .ascending, reposPerPage: numberOfReposPerPage)
        service.getRepositories(parametersList: parametersList) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                switch result {
                case .success(let list):
                    self.repositoriesList = list
                    self.viewDelegate?.repositoryListViewModel(self, didGetReposListWith: .success(list))
                case .failure(let error):
                    self.viewDelegate?.repositoryListViewModel(self, didGetReposListWith: .failure(error))
                }
            }
        }
    }
}

