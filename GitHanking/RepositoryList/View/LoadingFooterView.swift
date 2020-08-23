//
//  LoadingFooterView.swift
//  GitHanking
//
//  Created by Guadalupe Montefusco de Oliveira on 23/08/20.
//  Copyright © 2020 Guadalupe Montefusco de Oliveira. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

final class LoadingFooterView: UIView {
    
    var activityIndicatorView: NVActivityIndicatorView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    func configureView() {
        backgroundColor = .white
        configureActivityIndicator(with: .zero)
        activityIndicatorView?.startAnimating()
    }
    
    func configureActivityIndicator(with frame: CGRect, type: NVActivityIndicatorType = .ballRotateChase,
                                    color: UIColor = .bottomOrangeGradientColor, padding: CGFloat = 8.0) {
        let activityIndicatorView = NVActivityIndicatorView(frame: frame)
        activityIndicatorView.type = type
        activityIndicatorView.color = color
        activityIndicatorView.padding = padding
        addSubview(activityIndicatorView)
        self.activityIndicatorView = activityIndicatorView
        configureActivityIndicatorViewConstraints()
    }
    
    func configureActivityIndicatorViewConstraints() {
        activityIndicatorView?.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView?.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
        activityIndicatorView?.widthAnchor.constraint(equalToConstant: 45.0).isActive = true
        activityIndicatorView?.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        activityIndicatorView?.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        activityIndicatorView?.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
