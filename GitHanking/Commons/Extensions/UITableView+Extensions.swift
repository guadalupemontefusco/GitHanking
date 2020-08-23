//
//  UITableView+Extensions.swift
//  GitHanking
//
//  Created by Guadalupe Montefusco de Oliveira on 22/08/20.
//  Copyright © 2020 Guadalupe Montefusco de Oliveira. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(with type: T.Type) {
        let nib = UINib(nibName: type.reuseIdentifier, bundle: Bundle.main.self)
        register(nib, forCellReuseIdentifier: type.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(of type: T.Type, for indexPath: IndexPath, configure completion: ((T) -> Void)) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: type.reuseIdentifier,
                                                  for: indexPath) as? T else {
            return T()
        }
        completion(cell)
        return cell
    }
}
