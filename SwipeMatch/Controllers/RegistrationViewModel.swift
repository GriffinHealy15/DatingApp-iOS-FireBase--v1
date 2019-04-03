//
//  RegistrationViewModel.swift
//  SwipeMatch
//
//  Created by Griffin Healy on 4/2/19.
//  Copyright © 2019 Griffin Healy. All rights reserved.
//

import UIKit

class RegistrationViewModel {
    var fullName:String? {
        didSet { checkFormValidity() }
    }
    var email:String? {
        didSet { checkFormValidity() }
    }
    var password:String? {
        didSet { checkFormValidity() }
    }
    
    fileprivate func checkFormValidity() {
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        isFormValidObserver?(isFormValid)
    }
    
    //Reactive programming
    var isFormValidObserver: ((Bool) -> ())?
}
