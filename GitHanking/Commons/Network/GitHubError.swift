//
//  GitHubError.swift
//  GitHanking
//
//  Created by Guadalupe Montefusco de Oliveira on 22/08/20.
//  Copyright © 2020 Guadalupe Montefusco de Oliveira. All rights reserved.
//

enum GitHubError: Error {
    case parse
    case unknown
    case exception(GitHubErrorData)
}

