//
//  BaseViewController.swift
//  GitHanking
//
//  Created by Guadalupe Montefusco de Oliveira on 22/08/20.
//  Copyright © 2020 Guadalupe Montefusco de Oliveira. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class BaseViewController: UIViewController {
    
    private var activityIndicatorView: NVActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setActivityIndicator()
    }
    
    private func setActivityIndicator() {
        let rect = CGRect(origin: .zero, size: CGSize(width: 50.0, height: 50.0))
        configureActivityIndicator(with: rect, type: .circleStrokeSpin, color: .topGreenGradientColor, padding: 5.0)
    }
    
    func configureActivityIndicator(with frame: CGRect, type: NVActivityIndicatorType,
                                        color: UIColor, padding: CGFloat) {
        let activityIndicatorView = NVActivityIndicatorView(frame: frame)
        activityIndicatorView.type = type
        activityIndicatorView.color = color
        activityIndicatorView.padding = padding
        view.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.activityIndicatorView = activityIndicatorView
    }
    
    func showLoading() {
        activityIndicatorView?.startAnimating()
    }
    
    func hideLoading() {
        activityIndicatorView?.stopAnimating()
    }
}
