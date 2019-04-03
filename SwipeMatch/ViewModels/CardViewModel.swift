//
//  CardViewModel.swift
//  SwipeMatch
//
//  Created by Griffin Healy on 3/29/19.
//  Copyright © 2019 Griffin Healy. All rights reserved.
//

import UIKit


protocol ProducesCardViewModel {
    func toCardViewModel() -> CardViewModel 
}

// View model is supposed to represent the state of our view
class CardViewModel {
    // we'll define the properties that our view will display/render out
    let imageNames: [String]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
    
    init(imageNames: [String], attributedString: NSAttributedString, textAlignment: NSTextAlignment) {
        self.imageNames = imageNames
        self.attributedString = attributedString
        self.textAlignment = textAlignment
    }
    
    fileprivate var imageIndex = 0 {
        didSet {
            let imageName = imageNames[imageIndex]
            let image = UIImage(named: imageName)
            imageIndexObserver?(imageIndex, image ?? UIImage())
        }
    }
    
   // Reactive Programming
    var imageIndexObserver: ((Int, UIImage) -> ())?
    
   func advanceToNextPhoto() {
        imageIndex = min(imageIndex + 1, imageNames.count - 1)
    }
   func goToPreviousPhoto() {
        imageIndex = max(0, imageIndex - 1)
    }
}


