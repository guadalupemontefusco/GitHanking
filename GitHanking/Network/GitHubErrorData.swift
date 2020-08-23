//
//  GitHubErrorData.swift
//  GitHanking
//
//  Created by Guadalupe Montefusco de Oliveira on 22/08/20.
//  Copyright © 2020 Guadalupe Montefusco de Oliveira. All rights reserved.
//

import Foundation

struct GitHubErrorData: Codable, Error {
    let message: String
    let documentationURL: String
    let errors: [ErrorContent]?

    enum CodingKeys: String, CodingKey {
        case message, errors
        case documentationURL = "documentation_url"
    }
}

struct ErrorContent: Codable {
    let resource, field, code: String
}
