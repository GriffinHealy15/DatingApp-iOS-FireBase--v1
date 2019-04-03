//
//  CardView.swift
//  SwipeMatch
//
//  Created by Griffin Healy on 3/28/19.
//  Copyright © 2019 Griffin Healy. All rights reserved.
//

import UIKit

class CardView: UIView {
    // cardViewModel is passed current cardVm in HomeController
    var cardViewModel: CardViewModel! {
        didSet {
            // accessing index 0 will crash if imageNames.count == 0
            let imageName = cardViewModel.imageNames.first ?? ""
            imageView.image = UIImage(named: imageName)
            informationLabel.attributedText = cardViewModel.attributedString
            informationLabel.textAlignment = cardViewModel.textAlignment
            
            (0..<cardViewModel.imageNames.count).forEach { (_) in
                let barView = UIView()
                barView.backgroundColor = barDeselectedColor
                barsStackView.addArrangedSubview(barView)
            }
            barsStackView.arrangedSubviews.first?.backgroundColor = .white
            
            setupImageIndexObserver()
        }
    }
    // observes imageIndexObserver in CardViewModel through its closure
    fileprivate func  setupImageIndexObserver() {
        cardViewModel.imageIndexObserver = { [unowned self] (idx, image) in
            self.imageView.image = image
            self.barsStackView.arrangedSubviews.forEach({ (v) in
                v.backgroundColor = self.barDeselectedColor
            })
            self.barsStackView.arrangedSubviews[idx].backgroundColor = .white
        }
    }
    fileprivate let imageView = UIImageView(image: #imageLiteral(resourceName: "lady5c"))
    let gradientLayer = CAGradientLayer()
    fileprivate let informationLabel = UILabel()
    
    // Configurations
    fileprivate let threshold:CGFloat = 100
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture) //add panGesture to card view,  recognizer triggers handlePan
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    fileprivate func setupLayout() {
        layer.cornerRadius = 10
        clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.fillSuperview()
        setupBarsStackView()
        
        // add gradient layer
        setupGradientLayer()
        
        addSubview(informationLabel)
        informationLabel.anchor(top: nil, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))
        informationLabel.textColor = .white
        informationLabel.numberOfLines = 0
    }
    
    //var imageIndex = 0
    fileprivate let barDeselectedColor = UIColor(white: 1, alpha: 0.1)
    
    @objc fileprivate func handleTap(gesture: UITapGestureRecognizer) {
        let tapLocation =  gesture.location(in: nil)
        let shouldAdvanceNextPhoto = tapLocation.x > frame.width/2 ? true : false
        
        if shouldAdvanceNextPhoto {
            cardViewModel.advanceToNextPhoto()
        } else {
            cardViewModel.goToPreviousPhoto()
        }
    }
    
   fileprivate let barsStackView = UIStackView()
    
   fileprivate func setupBarsStackView() {
    addSubview(barsStackView)
    barsStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 5))
    barsStackView.spacing = 4
    barsStackView.distribution = .fillEqually
    }
    
   fileprivate func setupGradientLayer() {
        // draw a gradient with swift
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5,1.1]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 300, height: 400)
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        // we know here what CardView frame will be, real frame of CardView known CardView init
        gradientLayer.frame = self.frame
    }

    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        // if the gesture on the view has received changes
        switch gesture.state {
        case .began:
            superview?.subviews.forEach({ (subview) in
                subview.layer.removeAllAnimations()
            })
        case .changed:
            handleChanged(gesture)
        case .ended:
            handleEnded(gesture)
        default:
            ()
        }
    }
    
    fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
        // gesture recognizer has received touches recognized as a change
        //rotation
        // math to convert degrees to radians
        let translation = gesture.translation(in: nil)
        let degrees:CGFloat = translation.x / 20
        let angle = degrees * .pi / 180
        // transform the card view based on where the gesture tap is in the coordinate system
        let rotationalTransformation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationalTransformation.translatedBy(x: translation.x, y: translation.y)
    }
    
    fileprivate func handleEnded(_ gesture: UIPanGestureRecognizer) {

        let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
        let shouldDismissCard = abs(gesture.translation(in: nil).x) > threshold
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            if shouldDismissCard == true {
                self.frame = CGRect(x: 600 * translationDirection, y: 0, width: self.frame.width, height: self.frame.height)
            
            } else {
                self.transform = .identity
            }
        }) { (_) in
            self.transform = .identity
            if(shouldDismissCard) {
            self.removeFromSuperview()
            }
            //self.frame = CGRect(x: 0, y: 0, width: self.superview!.frame.width, height: self.superview!.frame.height)
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
