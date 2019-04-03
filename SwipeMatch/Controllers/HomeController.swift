//
//  ViewController.swift
//  SwipeMatch
//
//  Created by Griffin Healy on 3/28/19.
//  Copyright © 2019 Griffin Healy. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    // topStackView is stackView at top, which is the stackView within topStackView
    let topStackView = TopNavigationStackView() // put all subviews in top stackview
    // bottomStackView is stackView at top, which is the stackView within topStackView
    let cardDecksView = UIView()
    let buttonsStackView = HomeBottomControlsStackView() // put all subviews in buttons stackview
    
    let cardViewModels: [CardViewModel] = {
        let producers = [
            // take Users and create/turn them into CardViewModel objects
            User(name: "Kelly", age: 23, profession: "DJ", imageNames: ["kelly1", "kelly2", "kelly3"]),
            Advertiser(title: "Slide Out Menu", brandName: "Let's Build That App", posterPhotoName: "slide_out_menu_poster"),
            User(name: "Jane", age: 19, profession: "Teacher", imageNames: ["jane1", "jane2", "jane3"])
        ] as [ProducesCardViewModel]
        
        let viewModels = producers.map({return $0.toCardViewModel()})
        return viewModels
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topStackView.settingButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        setupLayout()
        setupDummyCards()
    }
    
    @objc func handleSettings() {
        let registrationController = RegistrationViewController()
        present(registrationController, animated: true)
    }
    
    fileprivate func setupDummyCards() {
        cardViewModels.forEach { (cardVM) in
            let cardView = CardView(frame: .zero)
            // give newely created cardView the current cardVM. on initializtion of cardView, didSet will set cardView view attributes (to display) with current cardVM attribute info
            cardView.cardViewModel = cardVM // set view model onto the card view itself
            cardDecksView.addSubview(cardView)
            cardView.fillSuperview()
        }
    }
    
    // MARK:- File Private
    fileprivate func setupLayout() { // set up overallStackview, holds topStackView & bottomStackView
        // put all subviews in stackview, i.e. topStackView is put in the overallStackView
        let overallStackView = UIStackView(arrangedSubviews: [topStackView,cardDecksView, buttonsStackView])
        view.addSubview(overallStackView)
        overallStackView.axis = .vertical
        //set stackView anchor constraints to constrain around superview respects top/bottom safe area
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        overallStackView.bringSubviewToFront(cardDecksView)
    }
}

