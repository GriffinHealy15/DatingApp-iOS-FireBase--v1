//
//  HomeBottomControlsStackView.swift
//  SwipeMatch
//
//  Created by Griffin Healy on 3/28/19.
//  Copyright © 2019 Griffin Healy. All rights reserved.
//

import UIKit

class HomeBottomControlsStackView: UIStackView {
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        distribution = .fillEqually // each subview added to stackview is filled equally to each other
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // go through each img in array, create 5 buttons for each image
    let subviews = [#imageLiteral(resourceName: "refresh_circle"),#imageLiteral(resourceName: "dismiss_circle"), #imageLiteral(resourceName: "super_like_circle"), #imageLiteral(resourceName: "like_circle"), #imageLiteral(resourceName: "boost_circle")].map { (img) -> UIView in //create temp img for each array img
            let button = UIButton(type: .system) // create button
            button.setImage(img.withRenderingMode(.alwaysOriginal), for: .normal) // set button's image with current img array value
            return button
        }
        
        // add each view as a subview to the stack we are creating. five buttons with images added
        subviews.forEach { (v) in
            addArrangedSubview(v)
        }
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
