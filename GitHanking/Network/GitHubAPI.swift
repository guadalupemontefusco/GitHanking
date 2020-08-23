//
//  GitHubAPI.swift
//  GitHanking
//
//  Created by Guadalupe Montefusco de Oliveira on 22/08/20.
//  Copyright © 2020 Guadalupe Montefusco de Oliveira. All rights reserved.
//

import Moya

enum GitHubAPI {
    case searchRepositories(ParametersList)
}

extension GitHubAPI: TargetType {

    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .searchRepositories:
            return "/search/repositories"
        }
    }
    
    var method: Method {
        switch self {
        case .searchRepositories:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var dictionaryParameters: [String: Any] {
        switch self {
        case .searchRepositories(let parameters):
            return try! parameters.asDictionary()
        }
    }
    
    var task: Task {
        switch self {
        case .searchRepositories:
            return .requestParameters(parameters: dictionaryParameters, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}

extension Encodable {
    
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
      guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
        throw NSError()
      }
      return dictionary
    }
}


