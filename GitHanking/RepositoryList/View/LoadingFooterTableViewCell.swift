//
//  LoadingFooterTableViewCell.swift
//  GitHanking
//
//  Created by Guadalupe Montefusco de Oliveira on 23/08/20.
//  Copyright © 2020 Guadalupe Montefusco de Oliveira. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

final class LoadingFooterTableViewCell: UITableViewHeaderFooterView {
    
    var activityIndicatorView: NVActivityIndicatorView?
    
    func configureView() {
        contentView.backgroundColor = .white
        configureActivityIndicator(with: .zero)
        activityIndicatorView?.startAnimating()
    }
    
    func configureActivityIndicator(with frame: CGRect, type: NVActivityIndicatorType = .ballRotateChase,
                                    color: UIColor = .bottomOrangeGradientColor, padding: CGFloat = 8.0) {
        let activityIndicatorView = NVActivityIndicatorView(frame: frame)
        activityIndicatorView.type = type
        activityIndicatorView.color = color
        activityIndicatorView.padding = padding
        contentView.addSubview(activityIndicatorView)
        self.activityIndicatorView = activityIndicatorView
        configureActivityIndicatorViewConstraints()
    }
    
    func configureActivityIndicatorViewConstraints() {
        activityIndicatorView?.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView?.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
        activityIndicatorView?.widthAnchor.constraint(equalToConstant: 45.0).isActive = true
        activityIndicatorView?.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        activityIndicatorView?.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        activityIndicatorView?.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
}
