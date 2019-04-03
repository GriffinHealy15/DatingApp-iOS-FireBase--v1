//
//  User.swift
//  SwipeMatch
//
//  Created by Griffin Healy on 3/28/19.
//  Copyright © 2019 Griffin Healy. All rights reserved.
//

import UIKit

struct User: ProducesCardViewModel {
    // defining our properties for our model layer
    let name: String
    let age: Int
    let profession: String
    let imageNames: [String]
    
    func toCardViewModel() -> CardViewModel {
        
        let attributedText = NSMutableAttributedString(string: name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        
        attributedText.append(NSAttributedString(string: "  \(age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
        
        attributedText.append(NSAttributedString(string: "\n \(profession)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        // take the User Model and make CardViewModel object by transfering attributes to it
        return CardViewModel(imageNames: imageNames, attributedString: attributedText, textAlignment: .left)
        
    }
    
}

