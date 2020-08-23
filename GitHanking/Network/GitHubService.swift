//
//  GitHubService.swift
//  GitHanking
//
//  Created by Guadalupe Montefusco de Oliveira on 22/08/20.
//  Copyright © 2020 Guadalupe Montefusco de Oliveira. All rights reserved.
//

import Foundation

final class GitHubService: BaseService {
    
    func getRepositories(parametersList: ParametersList,
                         completion: @escaping ((Result<RepositoriesList, GitHubError>) -> Void)) {
        request(from: .searchRepositories(parametersList), responseType: RepositoriesList.self) { result in
            switch result {
            case .success(let list):
                completion(.success(list))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
