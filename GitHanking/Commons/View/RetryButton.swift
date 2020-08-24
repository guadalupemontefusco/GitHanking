//
//  RetryButton.swift
//  GitHanking
//
//  Created by Guadalupe Montefusco de Oliveira on 23/08/20.
//  Copyright © 2020 Guadalupe Montefusco de Oliveira. All rights reserved.
//

import UIKit

final class RetryButton: UIButton {
    
    var retryAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        retryAction?()
    }
}
