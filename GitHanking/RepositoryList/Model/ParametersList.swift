//
//  ParametersList.swift
//  GitHanking
//
//  Created by Guadalupe Montefusco de Oliveira on 22/08/20.
//  Copyright © 2020 Guadalupe Montefusco de Oliveira. All rights reserved.
//

import Foundation

struct ParametersList: Codable {
    var language: CodeLanguage
    var sort: Sort?
    var nextPage: Int?
    var direction: Direction?
    var reposPerPage: Int?

    enum CodingKeys: String, CodingKey {
        case language = "q"
        case sort
        case nextPage = "page"
        case direction
        case reposPerPage = "per_page"
    }
}

enum Direction: String, Codable {
    case descending = "desc"
    case ascending = "asc"
}

enum CodeLanguage: String, Codable {
    case swift = "language:swift"
}

enum Sort: String, Codable {
    case stars
    case forks
    case updated
}

