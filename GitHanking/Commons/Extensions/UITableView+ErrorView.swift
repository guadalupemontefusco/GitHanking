//
//  UITableView+ErrorView.swift
//  GitHanking
//
//  Created by Guadalupe Montefusco de Oliveira on 23/08/20.
//  Copyright © 2020 Guadalupe Montefusco de Oliveira. All rights reserved.
//

import UIKit

extension UITableView {
    
    func addErrorView(retryAction: @escaping (() -> Void)) {
        let imageView = UIImageView(frame: .zero)
        imageView.image = #imageLiteral(resourceName: "001-warning")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        
        let label = UILabel(frame: .zero)
        label.text = "Oops! \nAn error is occurred."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .medium)

        let retryButton = RetryButton(frame: .zero)
        retryButton.setTitle("Try again", for: .normal)
        retryButton.setTitleColor(.systemBlue, for: .normal)
        retryButton.retryAction = retryAction
        retryButton.layer.borderWidth = 1.5
        retryButton.layer.borderColor = UIColor.systemBlue.cgColor
        retryButton.layer.cornerRadius = 18.0
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        retryButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        let stackViewFrame = CGRect(origin: .zero, size: CGSize(width: 60.0, height: 60.0))
        let stackView = UIStackView(frame: stackViewFrame)
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.tag = 1010
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(retryButton)
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
        
        retryButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 24).isActive = true
        retryButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -24).isActive = true
    }
    
    func removeErrorView() {
        self.viewWithTag(1010)?.removeFromSuperview()
    }
}
