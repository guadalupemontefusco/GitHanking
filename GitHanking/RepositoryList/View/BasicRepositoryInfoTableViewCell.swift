//
//  BasicRepositoryInfoTableViewCell.swift
//  GitHanking
//
//  Created by Guadalupe Montefusco de Oliveira on 16/08/20.
//  Copyright © 2020 Guadalupe Montefusco de Oliveira. All rights reserved.
//

import UIKit
import Kingfisher

class BasicRepositoryInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ownerAvatarImageView: UIImageView!
    @IBOutlet weak var ownerNicknameLabel: UILabel!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var stargazersCountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        contentView.backgroundColor = .white
        ownerAvatarImageView.clipsToBounds = true
        ownerAvatarImageView.layer.cornerRadius = 10.0
    }
    
    func configure(with listValues: Items) {
        ownerNicknameLabel.text = listValues.owner.login
        descriptionLabel.text = listValues.description
        repositoryNameLabel.text = listValues.fullName
        stargazersCountLabel.text = "\(listValues.stargazersCount)"

        ownerAvatarImageView.kf.setImage(with: URL(string: listValues.owner.avatarUrl), placeholder: nil, options: nil, progressBlock: nil) { [weak self] result in
            switch result {
            case .success:
                self?.ownerAvatarImageView.isHidden = false
            case .failure:
                self?.ownerAvatarImageView.isHidden = true
            }
        }
    }
}
