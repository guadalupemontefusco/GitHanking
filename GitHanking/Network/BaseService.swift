//
//  BaseService.swift
//  GitHanking
//
//  Created by Guadalupe Montefusco de Oliveira on 22/08/20.
//  Copyright © 2020 Guadalupe Montefusco de Oliveira. All rights reserved.
//

import Moya

class BaseService {
    
    let provider = MoyaProvider<GitHubAPI>(plugins: [NetworkLoggerPlugin()])
    
    func request<T: Codable>(from endpoint: GitHubAPI, responseType: T.Type,
                             completion: @escaping ((Result<T, GitHubError>) -> Void)) {
        provider.request(endpoint) { result in
            switch result {
            case .success(let response):
                let decoder = JSONDecoder()
                do {
                    let data = try decoder.decode(responseType, from: response.data)
                    completion(.success(data))
                } catch _ {
                    completion(.failure(GitHubError.parse))
                }
            case .failure(let moyaError):
                let decoder = JSONDecoder()
                do {
                    guard let data = moyaError.response?.data else {
                        completion(.failure(GitHubError.unknown))
                        return
                    }
                    let gitHubError = try decoder.decode(GitHubErrorData.self, from: data)
                    completion(.failure(GitHubError.exception(gitHubError)))
                } catch _ {
                    completion(.failure(GitHubError.unknown))
                }
            }
        }
    }
}
