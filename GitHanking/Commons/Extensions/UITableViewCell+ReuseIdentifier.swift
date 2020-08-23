//
//  UITableViewCell+ReuseIdentifier.swift
//  GitHanking
//
//  Created by Guadalupe Montefusco de Oliveira on 23/08/20.
//  Copyright © 2020 Guadalupe Montefusco de Oliveira. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
