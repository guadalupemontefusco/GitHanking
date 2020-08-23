//
//  CustomRefreshControl.swift
//  GitHanking
//
//  Created by Guadalupe Montefusco de Oliveira on 23/08/20.
//  Copyright © 2020 Guadalupe Montefusco de Oliveira. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class CustomRefreshControl: UIRefreshControl {
    
    private var activityIndicator: NVActivityIndicatorView!
    private var screenBounds: CGRect!
    
    var backgroundView: UIView!
    var backgroundViewColor: UIColor = .white {
        didSet {
            backgroundView.backgroundColor = backgroundViewColor
        }
    }
    
    init(screenBounds: CGRect = UIScreen.main.bounds,
         type: NVActivityIndicatorType = .ballClipRotate,
         color: UIColor = .darkGray) {
        super.init()
        self.screenBounds = screenBounds
        
        backgroundColor = .clear
        tintColor = .clear
        
        configureActivityIndicator(withColor: color, type: type)
        configureBackgroundView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func configureActivityIndicator(withColor color: UIColor, type: NVActivityIndicatorType) {
        let defaultSize = CGSize(width: 25.0, height: 25.0)
        activityIndicator = NVActivityIndicatorView(frame: CGRect(origin: .zero, size: defaultSize),
                                                    type: type, color: color)
        activityIndicator.startAnimating()
        activityIndicator.center.x = screenBounds.width / 2
        activityIndicator.frame.origin.y = -screenBounds.origin.y
        subviews[0].addSubview(activityIndicator)
    }
    
    private func configureBackgroundView() {
        screenBounds.origin.y = -screenBounds.size.height
        let backgroundView = UIView(frame: screenBounds)
        backgroundView.backgroundColor = backgroundViewColor
        self.backgroundView = backgroundView
    }
    
    func setActivityIndicator(with x: CGFloat, and y: CGFloat) {
        let defaultSize = CGSize(width: 25.0, height: 25.0)
        activityIndicator.frame = CGRect(origin: CGPoint(x: x, y: y), size: defaultSize)
    }
}
