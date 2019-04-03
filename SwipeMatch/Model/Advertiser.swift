//
//  Advertiser.swift
//  SwipeMatch
//
//  Created by Griffin Healy on 3/29/19.
//  Copyright © 2019 Griffin Healy. All rights reserved.
//

import UIKit

struct Advertiser: ProducesCardViewModel {
    let title: String
    let brandName: String
    let posterPhotoName: String
    
    // this basically converts this model to a CardViewModel, which holds all types of models
    func toCardViewModel() -> CardViewModel {
        
        let attributedText = NSMutableAttributedString(string: title, attributes:
            [.font: UIFont.systemFont(ofSize: 34, weight: .heavy)])
        
        attributedText.append(NSAttributedString(string: "\n" + brandName, attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .bold)]))
        
        return CardViewModel(imageNames: [posterPhotoName], attributedString: attributedText, textAlignment: .center)
    }
    
}
