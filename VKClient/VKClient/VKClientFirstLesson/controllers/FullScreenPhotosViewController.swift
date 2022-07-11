//
//  FullScreenPhotosViewController.swift
//  VKClientFirstLesson
//
//  Created by Алексей on 04.06.2022.
//

import UIKit

class FullScreenPhotosViewController: UIViewController {

    
    @IBOutlet weak var fullPhotoImage: UIImageView! {
        didSet {
            fullPhotoImage.isUserInteractionEnabled = true
        }
    }
    
    public var photos: [UIImage] = []
    public var selectedPhotoIndex: Int = 0
    private let additionalImageView = UIImageView()
    private var propertyAnimator: UIViewPropertyAnimator!
    
    
    enum AnimationDirection {
        case right
        case left
    }
    
    
    private var animationDirection: AnimationDirection = .left
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard !photos.isEmpty else {return}
        
        fullPhotoImage.image = photos[selectedPhotoIndex]
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeftFunc))
        leftSwipe.direction = .left
        fullPhotoImage.addGestureRecognizer(leftSwipe)
        
        
        view.addSubview(additionalImageView)
        view.sendSubviewToBack(additionalImageView)
        additionalImageView.translatesAutoresizingMaskIntoConstraints = false
        additionalImageView.contentMode = .scaleAspectFit
        
        
        NSLayoutConstraint.activate([
            additionalImageView.leadingAnchor.constraint(equalTo: fullPhotoImage.leadingAnchor),
            additionalImageView.trailingAnchor.constraint(equalTo: fullPhotoImage.trailingAnchor),
            additionalImageView.topAnchor.constraint(equalTo: fullPhotoImage.topAnchor),
            additionalImageView.bottomAnchor.constraint(equalTo: fullPhotoImage.bottomAnchor)
        ])
        
        
        
        let panTapOnSwipeGR = UIPanGestureRecognizer(target: self, action: #selector (pannedView(_:)))
        view.addGestureRecognizer(panTapOnSwipeGR)


    }
    

    @objc func pannedView(_ panGesture: UIPanGestureRecognizer) {
        
        switch panGesture.state {
       
        case .began:
            
            if panGesture.translation(in: view).x > 0 {
                // right
                guard selectedPhotoIndex >= 1 else {return}
                
                animationDirection = .right
                
                self.additionalImageView.transform = CGAffineTransform(translationX: -1.5*self.additionalImageView.bounds.width, y: 200).concatenating(CGAffineTransform(scaleX: 1.2, y: 1.2))
                self.additionalImageView.image = photos[selectedPhotoIndex - 1]
                
                propertyAnimator = UIViewPropertyAnimator(duration: 0.7, curve: .easeInOut, animations: {
                    
            
                    self.fullPhotoImage.transform = CGAffineTransform(translationX: 1.5*self.fullPhotoImage.bounds.width, y: -200).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
                    self.additionalImageView.transform = .identity
                    
                })
                
                propertyAnimator.addCompletion { position in
                    switch position {
                        
                    case .end:
                        self.selectedPhotoIndex -= 1
                        self.fullPhotoImage.image = self.photos[self.selectedPhotoIndex]
                        self.fullPhotoImage.transform = .identity
                        
                        self.additionalImageView.image = nil
                    case .start:
                        self.additionalImageView.transform = CGAffineTransform(translationX: -1.5*self.additionalImageView.bounds.width, y: 200).concatenating(CGAffineTransform(scaleX: 1.2, y: 1.2))
                    case .current:
                        break
                        
                    @unknown default:
                        break
                    }
                }
                
            } else {
                //left
                
                guard selectedPhotoIndex + 1 < photos.count else {return}
                
                animationDirection = .left
                
                self.additionalImageView.transform = CGAffineTransform(translationX: 1.5*self.additionalImageView.bounds.width, y: 200).concatenating(CGAffineTransform(scaleX: 1.2, y: 1.2))
                self.additionalImageView.image = photos[selectedPhotoIndex + 1]
                
                propertyAnimator = UIViewPropertyAnimator(duration: 0.7, curve: .easeInOut, animations: {
                    
                  
                    self.fullPhotoImage.transform = CGAffineTransform(translationX: -1.5*self.fullPhotoImage.bounds.width, y: -200).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
                    self.additionalImageView.transform = .identity
                    
                })
                
                propertyAnimator.addCompletion { position in
                    switch position {
                        
                    case .end:
                        self.selectedPhotoIndex += 1
                        self.fullPhotoImage.image = self.photos[self.selectedPhotoIndex]
                        self.fullPhotoImage.transform = .identity
                        
                        self.additionalImageView.image = nil
                    case .start:
                        self.additionalImageView.transform = CGAffineTransform(translationX: self.additionalImageView.bounds.width, y: 200).concatenating(CGAffineTransform(scaleX: 1.2, y: 1.2))
                    case .current:
                        break
                        
                    @unknown default:
                        break
                    }
                }
            }
            
            
            
        case .changed:
            
            switch animationDirection {
            case .left:
                let percent = min(max(0, -panGesture.translation(in: view).x/200),1)
                
                propertyAnimator.fractionComplete = percent
          
            case .right:
                let percent = min(max(0, panGesture.translation(in: view).x/200),1)
                
                propertyAnimator.fractionComplete = percent
                
            }
            
            
        case .ended:
            
            
            if propertyAnimator.fractionComplete > 0.7 {
                propertyAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0.5)
            } else {
                propertyAnimator.isReversed = true
                propertyAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0.5)
            }
         
        @unknown default:
            break
        }
        
    }
    
    
    @objc func swipeLeftFunc() {
        
        guard selectedPhotoIndex + 1 < photos.count else {return}
        
        additionalImageView.transform = CGAffineTransform(translationX: 1.5*additionalImageView.bounds.width, y: 100).concatenating(CGAffineTransform(scaleX: 1.2, y: 1.2))
        additionalImageView.image = photos[selectedPhotoIndex + 1]
        
        UIView.animate(withDuration: 1,
                       delay: 0,
                       options: .curveEaseInOut) {
            self.fullPhotoImage.transform = CGAffineTransform(translationX: -1.5*self.fullPhotoImage.bounds.width, y: -200).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
            
            self.additionalImageView.transform = .identity
            
            
        } completion: { _ in
            
            self.selectedPhotoIndex += 1
            self.fullPhotoImage.image = self.photos[self.selectedPhotoIndex]
            self.fullPhotoImage.transform = .identity
            
            self.additionalImageView.image = nil
        }
 
        
    }
    
    
    @IBAction func swipeRightUISwipe(_ sender: Any) {
        guard selectedPhotoIndex >= 1 else {return}
        
        
        additionalImageView.transform = CGAffineTransform(translationX: -1.5*additionalImageView.bounds.width, y: -200).concatenating(CGAffineTransform(scaleX: 1.2, y: 1.2))
        additionalImageView.image = photos[selectedPhotoIndex - 1]
        
        
        
        UIView.animate(withDuration: 1,
                       delay: 0,
                       options: .curveEaseInOut) {
            self.fullPhotoImage.transform = CGAffineTransform(translationX: 1.5*self.fullPhotoImage.bounds.width, y: -200).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
            
            self.additionalImageView.transform = .identity
        } completion: { _ in
            self.selectedPhotoIndex -= 1
            self.fullPhotoImage.image = self.photos[self.selectedPhotoIndex]
            self.fullPhotoImage.transform = .identity
            
           
        }
 
    }
   
}
